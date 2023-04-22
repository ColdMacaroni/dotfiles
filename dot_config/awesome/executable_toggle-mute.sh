#!/usr/bin/env sh
# Toggles mute for either audio (SINK) or mic (SOURCE) and sends a notification about it

if ! [ $# -eq 1 ]; then
    echo "Bad argument number"
    exit 1
fi

wpctl set-mute "@DEFAULT_AUDIO_$1@" toggle

if [ "$1" = "SOURCE" ]; then
    name="Mic"
elif [ "$1" = "SINK" ]; then
    name="Audio"
else
    echo "What kinda source is that??"
    exit 2
fi


if [ -z "$(wpctl get-volume @DEFAULT_AUDIO_$1@ | grep MUTED)" ]; then
    action="unmuted"
else
    action="muted"
fi

notify-send -t 800 "$name $action"
