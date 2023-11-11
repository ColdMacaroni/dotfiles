local awful = require "awful"
local key = awful.key

awful.keyboard.append_global_keybindings {
    key {
        modifiers = { modkey },
        key = "l",
        on_press = function()
            awful.tag.incmwfact(0.05)
        end,
        description = "increase master width factor",
        group = "layout",
    },

    key {
        modifiers = { modkey },
        key = "h",
        on_press = function()
            awful.tag.incmwfact(-0.05)
        end,
        description = "decrease master width factor",
        group = "layout",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "h",
        on_press = function()
            awful.tag.incnmaster(1, nil, true)
        end,
        description = "increase the number of master clients",
        group = "layout",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "l",
        on_press = function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        description = "decrease the number of master clients",
        group = "layout",
    },

    key {
        modifiers = { modkey, "Control" },
        key = "h",
        on_press = function()
            awful.tag.incncol(1, nil, true)
        end,
        description = "increase the number of columns",
        group = "layout",
    },

    key {
        modifiers = { modkey, "Control" },
        key = "l",
        on_press = function()
            awful.tag.incncol(-1, nil, true)
        end,
        description = "decrease the number of columns",
        group = "layout",
    },

    key {
        modifiers = { modkey },
        key = "space",
        on_press = function()
            awful.layout.inc(1)
        end,
        description = "select next",
        group = "layout",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "space",
        on_press = function()
            awful.layout.inc(-1)
        end,
        description = "select previous",
        group = "layout",
    },

    -- XXX: Remove or edit?
    key {
        modifiers = { modkey },
        keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
}
