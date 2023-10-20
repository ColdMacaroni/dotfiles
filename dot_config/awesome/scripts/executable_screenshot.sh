#!/usr/bin/env bash

fn="$HOME/pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S.%N').png"
SCPROG=shotgun
if [ "$1" = "all" ]; then
	$SCPROG "$fn"
else
	geometry="$(slop)"
	[ -z "$geometry" ] && exit 0
	$SCPROG -g "$geometry" "$fn"
fi

xclip -in -sel clip -t image/png <"$fn"

emoji="$(printf "🤓\n😎\n🧐\n😉\n😼\n" | shuf | head -1)"
notify-send -i "$fn" -u low "Saved and copied to clipboard! $emoji"
