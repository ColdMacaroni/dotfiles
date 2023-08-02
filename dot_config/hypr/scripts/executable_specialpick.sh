#!/usr/bin/env bash
workspaces=$(hyprctl -j workspaces | jq -r '.[] | select (.id < 0) | .name' | awk -F: '{ print $2 }' | sort | sed 's/^$/(default)/')

echo "$workspaces" | fuzzel -d --prompt="special:" --log-level=none | sed 's/^(default)$//'