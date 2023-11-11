local awful = require "awful"
local button = awful.button

awful.mouse.append_global_mousebindings {
    button {
        button = 3,
        on_press = function()
            require("widgets.menu"):toggle()
        end,
    },

    button { button = 4, on_press = awful.tag.viewprev },
    button { button = 5, on_press = awful.tag.viewnext },
}

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings {
        button {
            button = 1,
            on_press = function(c)
                c:activate { context = "mouse_click" }
            end,
        },
        button {
            modifiers = { modkey },
            button = 1,
            on_press = function(c)
                c:activate { context = "mouse_click", action = "mouse_move" }
            end,
        },
        button {
            modifiers = { modkey },
            button = 3,
            on_press = function(c)
                c:activate { context = "mouse_click", action = "mouse_resize" }
            end,
        },
    }
end)
