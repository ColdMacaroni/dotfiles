#!/usr/bin/env bash

sigint_child() {
	kill -INT "$childPID" 2>/dev/null
}

trap sigint_child SIGINT

fn="$1"

if [ -z "$fn" ]; then
  fn="$(date +"$HOME/recording_%Y-%M-%d_%H%M%S.mp4")"
  echo "Using '$fn' as a filename."
fi

# We need to give our recording a pass through ffmpeg for proper encoding
# So we'll write to a temp file in the mean time
tmpfn="$(basename "$fn" | xargs -I _ mktemp --suffix ._)"

# TODO: Doesn't work for floating windows

# Getting all windows from https://gist.github.com/dshoreman/278091a17c08e30c46c7e7988b7c2f7d#all-windows-from-all-visible-workspaces
WINDOWS="$(swaymsg -t get_tree | jq -r --argjson visible "$(swaymsg -t get_workspaces | jq -c '[.[] | select(.visible) | .id]')" '.. | (.nodes? // empty)[] | select(.type == "workspace" and .id == $visible[]) | .. | (.nodes? // empty)[] | select(.pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')"
echo "$WINDOWS"
GEOM=$(echo "$WINDOWS" | slurp)

if [ -z "$GEOM" ]; then
  exit 1
fi

printf '%s\0' "$GEOM" | xargs -0 wl-screenrec -f "$tmpfn" "${@:2}" -g &

# We wait for the child so that the user can hit ctrl-c to stop recording
childPID=$!
wait $childPID

echo ffmpeg -i "$tmpfn" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 60 "$fn"

# https://stackoverflow.com/a/20848224
ffmpeg -i "$tmpfn" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 60 "$fn"
rm "$tmpfn"
