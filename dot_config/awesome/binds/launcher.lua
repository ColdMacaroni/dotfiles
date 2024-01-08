local awful = require "awful"
local key = awful.key
local usr = require "user"

awful.keyboard.append_global_keybindings {
    key {
        modifiers = { modkey },
        key = "Return",
        on_press = function()
            awful.spawn(terminal .. " -e tmux new-session -t base ; new-window")
        end,
        description = "open a tmux'd terminal",
        group = "launcher",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "Return",
        on_press = function()
            awful.spawn(terminal)
        end,
        description = "open a normal terminal",
        group = "launcher",
    },

    -- Prompt
    key {
        modifiers = { modkey },
        key = "d",
        on_press = function()
            -- Close using same shortcut that starts it

            -- I have no FUCKING idea why it doesn't work normally however:
            --   - Using rofi without reading its output make certain stuff like steam and webcord not work.
            --   - I went with this approach because it's the shortest one, empty callback for output.
            --   - actually losing my mind
            awful.spawn.easy_async(
                "rofi -show drun -kb-cancel Escape,Control+g,Control+bracketleft,Super+d",
                function() end
            )
        end,
        description = "run rofi",
        group = "launcher",
    },

    key {
        modifiers = { modkey },
        key = "p",
        on_press = function()
            awful.spawn.with_shell "colorpicker --one-shot --preview --short | tr -d '\\n' | xclip -in -sel clip"
        end,
        description = "spawn colour picker",
        group = "launcher",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "s",
        on_press = function()
            awful.spawn(usr.get_script "screenshot.sh", 0)
        end,
        description = "screenshot area",
        group = "launcher",
    },
}
