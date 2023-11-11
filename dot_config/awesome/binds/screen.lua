local awful = require "awful"
local key = awful.key

awful.keyboard.append_global_keybindings {
    key {
        modifiers = { modkey, "Control" },
        key = "j",
        on_press = function()
            awful.screen.focus_relative(-1)
        end,
        description = "focus the previous screen",
        group = "screen",
    },

    key {
        modifiers = { modkey, "Control" },
        key = "k",
        on_press = function()
            awful.screen.focus_relative(1)
        end,
        description = "focus the next screen",
        group = "screen",
    },
}
