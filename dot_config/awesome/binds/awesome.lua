-- AwesomeWM management stuff
local awful = require "awful"
local key = awful.key
local fs = require "gears.filesystem"
local hotkeys_popup = require "awful.hotkeys_popup"

awful.keyboard.append_global_keybindings {
    -- Do i want to keep the prompt box? It's good as a fallback but idk
    --[[ key {
        modifiers = { modkey },
        key = "r",
        on_press = function()
            awful.screen.focused().mypromptbox:run()
        end,
         description = "run prompt", group = "launcher"
    }, ]]

    key {
        modifiers = { modkey },
        key = "s",
        on_press = hotkeys_popup.show_help,
        description = "show help",
        group = "awesome",
    },

    key {
        modifiers = { modkey },
        key = "w",
        on_press = function()
            require("widgets.menu"):show()
        end,
        description = "show main menu",
        group = "awesome",
    },

    key {
        modifiers = { modkey, "Control" },
        key = "r",
        on_press = awesome.restart,
        description = "reload awesome",
        group = "awesome",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "e",
        on_press = awesome.quit,
        description = "quit awesome",
        group = "awesome",
    },

    key {
        modifiers = { modkey },
        key = "x",
        on_press = function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = fs.get_cache_dir() .. "/history_eval",
            }
        end,
        description = "lua execute prompt",
        group = "awesome",
    },
}
-- vim: errorformat=ERROR\:\ %f\:%l\:\ %m
