local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"

local usr = require "user"

local theme_dir = usr.theme_dir or gears.filesystem.get_themes_dir() .. "default/"

beautiful.init(theme_dir .. "theme.lua")

-- This is the nicest way to to do this. Unfortunately
-- I think I should make my own or take the one from here https://github.com/kosorin/awesome-rice
local hotkeys_popup = require "awful.hotkeys_popup"
for _, name in ipairs {
    "awesome",
    "client",
    "launcher",
    "layout",
    "screen",
    "multimedia",
    "mpris",
    "tag",
    "tmux: misc",
    "tmux: sessions",
    "tmux: panes",
    "tmux: windows",
    "Firefox: tabs",
} do
    hotkeys_popup.widget.add_group_rules(name, { color = beautiful.hotkeys_label_bg })
end

-- TODO: Is this right? Check docs. Fix this mess goddam
-- From https://old.reddit.com/r/awesomewm/comments/9lvkvg/increase_margin_to_the_text_inside_notifications/e79r0kd/
-- Needs to be set by hand..
naughty.config.defaults.margin = beautiful.notification_margin

-- Pick your theme, or set to nil for default
-- Current themes: sotil
-- local theme = "sotil"
-- NOTE: This could be changed to be for multiple widgets.
-- local theme_wibar = nil

-- if theme then
--     local themedir = gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "/"
--     beautiful.init(themedir .. "theme.lua")
--
--     -- Try and get a wibar, need to use dofile to use absolute path
--     if gears.filesystem.file_readable(themedir .. "wibar.lua") then
--         theme_wibar = dofile(themedir .. "wibar.lua")
--     end
-- else
-- end

-- Check if the theme has a bar.
