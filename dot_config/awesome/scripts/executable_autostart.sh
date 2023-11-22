#!/usr/bin/env zsh
# Autostarts stuff,, once

typeset -A args
typeset -a cmds

# Define autostart programs
# qt has a version issue but uh this works
#env -i DISPLAY=$DISPLAY 
cmds=(
    "nm-applet"
    "opensnitch-ui"
    "picom"
    "mpris-proxy"      # Used for forwarding audio control. Bluetooth speaker and headphones didn't really work without it.
)

# Define args from programs
# args["program"]="args"

for cmd in $cmds; do
    # Only run if not already running
    if ! pgrep "$cmd" &> /dev/null; then
        eval $cmd ${args["$cmd"]} &
    fi
done

