#!/usr/bin/env bash

# Load buttons
~/bin/tablet-buttons.sh

# Make tablet only work in current display
current="$(~/bin/get_current_screen.sh)"
xinput map-to-output "Tablet Monitor stylus" "$current"

notify-send "Tablet Loaded 👍" "Mapped to $current"
