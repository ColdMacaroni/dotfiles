#!/usr/bin/env bash

fn="$HOME/pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S.%N').png"
SCPROG=shotgun
if [ "$1" = "all" ]; then
    $SCPROG "$fn"
else
    # This conditional shader is useful for when picom isn't running,
    # otherwise it'd just not run

    # shellcheck disable=2037
    get_geo="slop -n 1"

    if pgrep picom > /dev/null 2>&1; then 
        # shellcheck disable=2037
        get_geo="slop -n 1 -l -r darken"
    fi

    geometry="$($get_geo)"
    [ -z "$geometry" ] && exit 0
    $SCPROG -g "$geometry" "$fn"
fi

xclip -in -sel clip -t image/png <"$fn"

emoji="$(printf "🤓\n😎\n🧐\n😉\n😼\n" | shuf | head -1)"
notify-send -i "$fn" -u low "Saved and copied to clipboard! $emoji"
