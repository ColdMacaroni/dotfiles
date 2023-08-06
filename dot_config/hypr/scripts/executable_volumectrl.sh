#!/usr/bin/env sh
# Volume controls that update eww!
# They're on a poll, but this way the bar gets instant feedback
if [ "$1" != "sink" ] && [ "$1" != "source" ]; then
  echo "Unknown wpctl thing: $1"
  exit 1
fi

if [ "$2" != "up" ] && [ "$2" != "down" ] && [ "$2" != "mute" ]; then
  echo "Unknown action: $2"
  exit 2
fi

noun="$1"
action="$2"

case "$noun" in
  sink)
    wp_var=@DEFAULT_AUDIO_SINK@
    ;;
  source)
    wp_var=@DEFAULT_AUDIO_SOURCE@
    ;;
  *)
    echo "Unreachable action! $action"
    exit 127
    ;;
esac

if [ "$action" = "mute" ]; then
  wpctl set-mute "$wp_var" toggle
else
  case "$action" in
    up)
      vol='2.5%+'
      ;;
    down)
      vol='2.5%-'
      ;;
    *)
      echo "Unreachable! $vol"
      exit 200
  esac

  wpctl set-volume -l 1.5 "$wp_var" "$vol"
fi

# It's probably better to do this rather than tryna check stuff
sinkinfo="$(wpctl get-volume @DEFAULT_AUDIO_SINK@  | awk '{print "{\"volume\": "$2 * 100 ", \"muted\": " ($3 == "[MUTED]" ? "true" : "false") "}" }')"
sourceinfo="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{ print ($3 != "[MUTED]" ? "true" : "false") }')"

eww update volume="$sinkinfo" micunmuted="$sourceinfo"
