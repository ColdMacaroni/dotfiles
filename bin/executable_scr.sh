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

# These 3 UPPERCASE bits taken directly from https://github.com/hyprwm/contrib/blob/main/grimblast/grimblast
WORKSPACES="$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')"
WINDOWS="$(hyprctl clients -j | jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))')"
GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp)

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
