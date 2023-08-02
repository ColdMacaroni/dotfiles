#!/bin/bash
# Hyprland script that moves window if floating or swaps in the given direction.

INCREMENT=55

if [ -z "$1" ]; then
	echo 2>&1 "Argument where?"
	exit 1
fi

isFloating="$(hyprctl -j activewindow | jq .floating)"
if [ "$isFloating" = "true" ]; then
	x=0
	y=0
	case "$1" in
	d | down)
		y=$INCREMENT
		;;

	l | left)
		x=-$INCREMENT
		;;

	r | right)
		x=$INCREMENT
		;;

	u | up)
		y=-$INCREMENT
		;;

	*)
		echo 2>&1 Bad direction
		exit 3
		;;
	esac
	hyprctl dispatch moveactive "$x" "$y"

elif [ "$isFloating" = "false" ]; then
	hyprctl dispatch swapwindow "$1"
else
	echo 2>&1 "No window found"
	exit 2
fi
