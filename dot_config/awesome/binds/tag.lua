-- Keybindings related to tags

local awful = require "awful"
local key = awful.key

awful.keyboard.append_global_keybindings {

    -- awful.key({ modkey }, "h", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    --
    -- awful.key({ modkey }, "l", awful.tag.viewnext, { description = "view next", group = "tag" }),
    key {
        modifiers = { modkey },
        key = "Left",
        on_press = awful.tag.viewprev,
        description = "view previous",
        group = "tag",
    },

    key {
        modifiers = { modkey },
        key = "Right",
        on_press = awful.tag.viewnext,
        description = "view next",
        group = "tag",
    },

    key {
        modifiers = { modkey },
        key = "Escape",
        on_press = awful.tag.history.restore,
        description = "go to previous tag",
        group = "tag",
    },

    -- Tag management

    key {
        modifiers = { modkey },
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    key {
        modifiers = { modkey, "Control" },
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    key {
        modifiers = { modkey, "Shift" },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },

    key {
        modifiers = { modkey, "Control", "Shift" },
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },

    key {
        modifiers = { modkey },
        key = "i",
        on_press = function()
            awful.prompt.run {
                prompt = "Rename: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = function(txt)
                    awful.screen.focused().selected_tag.name = txt
                end,
            }
        end,
        description = "rename tag",
        group = "tag",
    },
}
