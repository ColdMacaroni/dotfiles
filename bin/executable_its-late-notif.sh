#!/usr/bin/sh
# A reminder to sleep. You should add this to your crontab I think.

response="$(notify-send -t 30000 --action=yes="Sorry" --action=no="Go away" "Look at the time." "It's really late...")"

if [ "$response" = "yes" ]; then
    # Do we shutdown or nah?
    response="$(notify-send -t 30000 --action=poweroff="Poweroff" --action=nothing="I'll sleep soon" "That's okay." "What now?")"

    if [ "$response" = "poweroff" ]; then
        notify-send -t 3500 'Good night!' "Sleep well."

        sleep 3s

        if ! poweroff; then
            notify-send 'Sorry!' "I wasn't able to run poweroff."
        fi
    else
        notify-send -t 5000 "Alright ¬¬" "Goodnight."
    fi

else
    notify-send -t 3000 "Wow." "That's just rude"
fi

