#!/usr/bin/env sh
# Toggles mute and sends a notification about it
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle


if [ -z "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)" ]; then
    msg="Audio unmuted"
else
    msg="Audio muted"
fi

notify-send "$msg"
