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
    "emacs"
)

# Define args from programs
# args["program"]="args"
args["emacs"]="--daemon"

for cmd in $cmds; do
    # Only run if not already running
    if ! pgrep "$cmd" &> /dev/null; then
        eval $cmd ${args["$cmd"]} &
    fi
done

