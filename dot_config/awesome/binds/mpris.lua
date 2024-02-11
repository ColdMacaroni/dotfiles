-- Keybindings that bind to playerctl (via the widget)
local awful = require "awful"
local key = awful.key
local mpris = require "widgets.mpris"

local playerctl_mode = awful.keygrabber {
    keybindings = {
        key {
            modifiers = { modkey },
            key = "p",
            on_press = mpris.playpause,
            description = "play/pause",
            group = "mpris",
        },

        key {
            modifiers = { modkey },
            key = "n",
            on_press = mpris.next,
            description = "next",
            group = "mpris",
        },

        key {
            modifiers = { modkey, "Shift" },
            key = "N",
            on_press = mpris.prev,
            description = "prev",
            group = "mpris",
        },

        key {
            modifiers = { modkey },
            key = "m",
            on_press = mpris.next_player,
            description = "next player",
            group = "mpris",
        },

        key {
            modifiers = { modkey, "Shift" },
            key = "M",
            on_press = mpris.prev_player,
            description = "prev player",
            group = "mpris",
        },
    },
    stop_key = { "q", "Escape" },
    start_callback = function()
        require("widgets.mode").update "mpris"
    end,
    stop_callback = require("widgets.mode").clear,
    timeout = 0.2,
}

awful.keyboard.append_global_keybindings {
    key {
        modifiers = { modkey },
        key = "p",
        on_press = playerctl_mode,
        description = "enter mpris mode",
        group = "mpris",
    },
}
