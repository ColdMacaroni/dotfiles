#!/usr/bin/env sh
# Kills all detached tmux sessions
tmux list-sessions -F '#{session_attached} #{session_id}' | awk '/^0/{system("tmux kill-session -t \\" $2)}'
