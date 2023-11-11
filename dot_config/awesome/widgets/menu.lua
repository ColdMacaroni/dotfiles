local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local usr = require "user"
local beautiful = require "beautiful"

-- Create a launcher widget and a main menu
local awesome_menu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", usr.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}

awful.spawn()

local main = awful.menu {
    items = {
        { "awesome", awesome_menu, beautiful.awesome_icon },
        { "open terminal", terminal },
    },
}

return main
