-- Client management. This file sets the request::default_keybindings signal.
local awful = require "awful"
local key = awful.key

awful.keyboard.append_global_keybindings {
    key {
        modifiers = { modkey },
        key = "k",
        on_press = function()
            awful.client.focus.byidx(1)
        end,
        description = "focus next by index",
        group = "client",
    },

    key {
        modifiers = { modkey },
        key = "j",
        on_press = function()
            awful.client.focus.byidx(-1)
        end,
        description = "focus previous by index",
        group = "client",
    },

    -- XXX: Delete?
    key {
        modifiers = { modkey },
        key = "Tab",
        on_press = function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        description = "go back",
        group = "client",
    },

    key {
        modifiers = { modkey, "Control" },
        key = "n",
        on_press = function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        description = "restore minimized",
        group = "client",
    },
    key {
        modifiers = { modkey, "Shift" },
        key = "j",
        on_press = function()
            awful.client.swap.byidx(-1)
        end,
        description = "swap with previous client by index",
        group = "client",
    },
    key {
        modifiers = { modkey, "Shift" },
        key = "k",
        on_press = function()
            awful.client.swap.byidx(1)
        end,
        description = "swap with next client by index",
        group = "client",
    },
    key {
        modifiers = { modkey },
        key = "u",
        on_press = awful.client.urgent.jumpto,
        description = "jump to urgent client",
        group = "client",
    },
}

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        key {
            modifiers = { modkey },
            key = "f",
            on_press = function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            description = "toggle fullscreen",
            group = "client",
        },

        key {
            modifiers = { modkey, "Shift" },
            key = "q",
            on_press = function(c)
                c:kill()
            end,
            description = "close",
            group = "client",
        },

        key {
            modifiers = { modkey, "Control" },
            key = "space",
            on_press = awful.client.floating.toggle,
            description = "toggle floating",
            group = "client",
        },

        key {
            modifiers = { modkey, "Control" },
            key = "Return",
            on_press = function(c)
                c:swap(awful.client.getmaster())
            end,
            description = "move to master",
            group = "client",
        },

        -- XXX: What does this do?
        key {
            modifiers = { modkey },
            key = "o",
            on_press = function(c)
                c:move_to_screen()
            end,
            description = "move to screen",
            group = "client",
        },

        key {
            modifiers = { modkey },
            key = "t",
            on_press = function(c)
                c.ontop = not c.ontop
            end,
            description = "toggle keep on top",
            group = "client",
        },

        key {
            modifiers = { modkey },
            key = "n",
            on_press = function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            description = "minimize",
            group = "client",
        },

        key {
            modifiers = { modkey },
            key = "m",
            on_press = function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            description = "(un)maximize",
            group = "client",
        },

        key {
            modifiers = { modkey, "Control" },
            key = "m",
            on_press = function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            description = "(un)maximize vertically",
            group = "client",
        },

        key {
            modifiers = { modkey, "Shift" },
            key = "m",
            on_press = function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            description = "(un)maximize horizontally",
            group = "client",
        },

        -- Toggle titlebar. https://awesomewm.org/doc/api/classes/awful.titlebar.html#awful.titlebar:toggle
        key {
            modifiers = { modkey, "Shift" },
            key = "t",
            on_press = function(c)
                awful.titlebar.toggle(c)
            end,
            description = "toggle titlebar",
            group = "client",
        },

        -- Center window
        key {
            modifiers = { modkey },
            key = "c",
            on_press = awful.placement.centered,
            description = "center client",
            group = "client",
        },
    }
end)
