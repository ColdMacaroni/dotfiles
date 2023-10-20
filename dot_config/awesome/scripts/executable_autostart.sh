#!/usr/bin/env zsh
# Autostarts stuff,, once

typeset -A args
typeset -a cmds

# Define autostart programs
# qt has a version issue but uh this works
#env -i DISPLAY=$DISPLAY 
cmds=("cbatticon" "nm-applet" "opensnitch-ui" "picom")

# Define args from programs
args["cbatticon"]="-r 5 -c poweroff"

for cmd in $cmds; do
    # Only run if not already running
    if ! pgrep "$cmd" &> /dev/null; then
        eval $cmd ${args["$cmd"]} &
    fi
done

