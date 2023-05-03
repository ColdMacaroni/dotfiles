#!/usr/bin/env zsh
# Autostarts stuff,, once

typeset -A args
typeset -a cmds

# Define autostart programs
cmds=("cbatticon" "nm-applet" "opensnitch-ui" "light-locker" "picom")

# Define args from programs
args["cbatticon"]="-r 5 -c poweroff"

for cmd in $cmds; do
    # Only run if not already running
    if ! pgrep "$cmd" &> /dev/null; then
        eval $cmd ${args["$cmd"]} &
    fi
done

