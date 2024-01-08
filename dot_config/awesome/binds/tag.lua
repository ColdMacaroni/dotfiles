-- Keybindings related to tags

local awful = require "awful"
local key = awful.key

local function index_of_tag(s, t)
    for idx, other_t in ipairs(s.tags) do
        if other_t == t then
            return idx
        end
    end
end

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
                    -- Use tag index if name is empty
                    if txt == "" then
                        txt = tostring(
                            index_of_tag(
                                awful.screen.focused(),
                                awful.screen.focused().selected_tag
                            ) % 10
                        )
                    end

                    awful.screen.focused().selected_tag.name = txt
                end,
            }
        end,
        description = "rename tag",
        group = "tag",
    },

    key {
        modifiers = { modkey, "Shift" },
        key = "o",
        on_press = function()
            local this_screen = awful.screen.focused()

            -- Wrapping around.
            local other_screen_idx = this_screen.index % screen.count() + 1
            local other_screen = screen[other_screen_idx]

            local this_tag = this_screen.selected_tag
            local other_tag = other_screen.selected_tag

            -- Store idxs for fixing names
            local this_tag_idx = index_of_tag(this_screen, this_tag)
            local other_tag_idx = index_of_tag(other_screen, other_tag)

            -- Make sure we don't lose focus
            this_tag:swap(other_tag)
            other_tag:view_only()
            this_tag:view_only()

            -- Make names match index
            local function fix_name(t, correct_idx)
                local num = tonumber(t.name, 10)
                -- Only change if it's a default name (0-9)
                if num and num < 10 then
                    t.name = tostring(correct_idx % 10)
                end
            end

            fix_name(this_tag, other_tag_idx)
            fix_name(other_tag, this_tag_idx)
        end,
        description = "swap tag with next screen's",
        group = "tag",
    },
}
