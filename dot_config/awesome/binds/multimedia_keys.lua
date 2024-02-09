local awful = require "awful"
local key = awful.key
local gears = require "gears"
local usr = require "user"

local update_sound = require("widgets.sound").force_update

awful.keyboard.append_global_keybindings {
    key {
        key = "XF86AudioMute",
        on_press = function()
            awful.spawn(usr.get_script "toggle-mute.sh SINK", false)

            -- Run after 0.05s because otherwise it's unreliable.
            gears.timer {
                timeout = 0.05,
                autostart = true,
                single_shot = true,
                callback = update_sound,
            }
        end,
        -- description = "toggle mute",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioLowerVolume",
        on_press = function()
            awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-", 0)
            update_sound()
        end,
        -- description = "lower mute",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioRaiseVolume",
        on_press = function()
            awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+", 0)
            update_sound()
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
        on_press = require "widgets.mpris".play,
        -- description = "play media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioPause",
        on_press = require "widgets.mpris".pause,
        -- description = "pause media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioNext",
        on_press = require "widgets.mpris".next,
        -- description = "next media",
        -- group = "multimedia",
    },
    key {
        key = "XF86AudioPrev",
        on_press = require "widgets.mpris".prev,
        -- description = "previous media",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioRewind",
        on_press = function() require "widgets.mpris".position("1.5-") end,
        -- description = "previous media",
        -- group = "multimedia",
    },

    key {
        key = "XF86AudioForward",
        on_press = function() require "widgets.mpris".position("1.5+") end,
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
