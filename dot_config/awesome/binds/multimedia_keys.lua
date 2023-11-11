local awful = require "awful"
local key = awful.key
local usr = require "user"

awful.keyboard.append_global_keybindings {
    key {
        key = "XF86AudioMute",
        on_press = function()
            awful.spawn(usr.get_script "toggle-mute.sh SINK", 0)
        end,
        -- description = "toggle mute",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioLowerVolume",
        on_press = function()
            awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-", 0)
        end,
        -- description = "lower mute",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioRaiseVolume",
        on_press = function()
            awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+", 0)
        end,
        -- description = "higher volume",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioMicMute",
        on_press = function()
            awful.spawn(usr.get_script "toggle-mute.sh SOURCE", 0)
        end,
        -- description = "toggle microphone mute",
        -- group = "multimedia",
    },

    -- Media keys
    key {
        key = "XF86AudioPlay",
        on_press = function()
            awful.spawn("playerctl play", 0)
        end,
        -- description = "play media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioPause",
        on_press = function()
            awful.spawn("playerctl pause", 0)
        end,
        -- description = "pause media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioNext",
        on_press = function()
            awful.spawn("playerctl next", 0)
        end,
        -- description = "next media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioPrev",
        on_press = function()
            awful.spawn("playerctl previous", 0)
        end,
        -- description = "previous media",
        -- group = "multimedia",
    },

    -- Brightness
    key {
        key = "XF86MonBrightnessDown",
        on_press = function()
            awful.spawn("light -s sysfs/backlight/intel_backlight -U 5", 0)
        end,
        -- description = "lower brightness",
        -- group = "multimedia",
    },

    key {
        key = "XF86MonBrightnessUp",
        on_press = function()
            awful.spawn("light -s sysfs/backlight/intel_backlight -A 5", 0)
        end,
        -- description = "higher brightness",
        -- group = "multimedia",
    },

    -- Screenshot key
    key {
        key = "Print",
        on_press = function()
            awful.spawn(usr.get_script "screenshot.sh all", 0)
        end,
        -- description = "screenshot all screens",
        -- group = "multimedia",
    },
    -- TODO: Shift print or something for single screen.
}
