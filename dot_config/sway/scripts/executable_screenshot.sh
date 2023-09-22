#!/usr/bin/env bash
fn="$HOME/pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S.%N').png"

if [ "$1" = "all" ]; then
  grim "$fn"
else
  geometry="$(slurp)" 
  [ -z "$geometry" ] && exit 0;
  grim -g "$geometry" "$fn"
fi

wl-copy < "$fn"

emoji="$(printf "🤓\n😎\n🧐\n😉\n😼\n" | shuf | head -1)"
notify-send -i "$fn" -u low "Saved and copied to clipboard! $emoji"
