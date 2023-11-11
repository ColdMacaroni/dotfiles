#!/usr/bin/env sh
# Runs the config in a Xephyr window.

killall picom

set -e
awesome -k ~/.config/awesome/rc.lua

(

dummy=:5
Xephyr $dummy -ac -br -screen 960x540 &

export DISPLAY=$dummy

sleep 1

# picom explodes generally
(sleep 2 && killall picom)&

# doing this so i can hit ctrl c on the awesomewm process.
(sleep 2 && wezterm start --always-new-process)&
(sleep 2 && wezterm start --always-new-process)&
(sleep 2 && wezterm start --always-new-process)&

awesome
# Stop nvim from dragging me to non-existent files
) > /dev/null 2> /dev/null
