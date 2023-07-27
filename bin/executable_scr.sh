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

# We wait for the child so that the user can hit ctrl-c to stop recording
# printf '%s\0' "$(slurp)" | xargs -0 wl-screenrec -f "$tmpfn" "${@:2}" -g &
printf '%s\0' "$(slurp)" | xargs -0 wl-screenrec -f "$tmpfn" "${@:2}" -g &

childPID=$!
wait $childPID

echo ffmpeg -i "$tmpfn" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 60 "$fn"

# https://stackoverflow.com/a/20848224
ffmpeg -i "$tmpfn" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 60 "$fn"
rm "$tmpfn"
