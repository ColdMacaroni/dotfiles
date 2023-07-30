#!/usr/bin/env sh 

# true: window in special, false: window not in special
if [ "$(hyprctl -j activewindow | jq '.workspace.id < 0')" = "true" ]; then 
  # Little hack to move it into the current workspace
  hyprctl dispatch movetoworkspacesilent +0
else
  # Accept special workspace name as argument
  hyprctl dispatch movetoworkspacesilent "special:$1"
fi
