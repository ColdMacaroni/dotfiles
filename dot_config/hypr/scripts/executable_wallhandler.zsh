#!/usr/bin/env zsh
# USR1 -> Next
# USR2 -> Prev

# {{{ Check process isn't already running
NAME=wallhandler
jobs -Z "$NAME"

if [ "$1" = "reload" ]; then
  kill $(pgrep "^$NAME$" | grep -v "$$" | tr $'\n' ' ')
  pkill hyprpaper
# Two processes, mine and pgrep itself.
elif [ "$(pgrep "^$NAME$" | wc -l)" -gt 2 ] ; then
  echo 1>&2 "Process named $NAME already exists, bye"
  exit 1
fi
# }}}

hyprpaper &

# Just need to give hyprpaper a sec to wake up, gotta make sure this script
# doesn't die in that time tho
trap true USR1
trap true USR2
sleep 1

# Wallpapers
set -A wallpapers

wallpapers=(
  "/usr/share/hyprland/wall_anime_2K.png"
  "/usr/share/backgrounds/celeste_campfire.jpg"
  "$HOME/pictures/betterhypr.png"
)

idx=1

updatebg() {
  wall="${wallpapers[$idx]}"

  for mon in $(hyprctl -j monitors | jq -Mcr '.[].name'); do
    hyprctl hyprpaper wallpaper "$mon,$wall"
  done
}

# Our USR1 signal handler
usr1_trap(){
  # Go to the next wallpaper
  echo hi
  idx=$(( (idx) % "${#wallpapers}" + 1 ))

  updatebg
}

usr2_trap(){
  # Go to the next wallpaper
  idx=$(( (idx - 1) % "${#wallpapers}" ))
  [ "$idx" -le 0 ] && idx="${#wallpapers}"

  updatebg
}

trap usr1_trap USR1
trap usr2_trap USR2

# hyprctl hyprpaper unload all
for x in $wallpapers; do
  echo "$x"
  hyprctl hyprpaper preload "$x"
done

# This loop and signal handling from https://stackoverflow.com/a/68712247
# ^ Very good answer!
# Wait in background, not consuming CPU
while :; do
   sleep 9223372036854775807 & # int max (2^63 - 1)
   wait $!
done

