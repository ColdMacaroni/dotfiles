local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a bar for the screen.
local function create_wibar(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen = s,
        buttons = {
            awful.button({}, 1, function()
                awful.layout.inc(1)
            end),
            awful.button({}, 3, function()
                awful.layout.inc(-1)
            end),
            awful.button({}, 4, function()
                awful.layout.inc(-1)
            end),
            awful.button({}, 5, function()
                awful.layout.inc(1)
            end),
        },
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t)
                t:view_only()
            end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end),
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({}, 3, function()
                awful.menu.client_list { theme = { width = 250 } }
            end),
            awful.button({}, 4, function()
                awful.client.focus.byidx(-1)
            end),
            awful.button({}, 5, function()
                awful.client.focus.byidx(1)
            end),
        },
    }

    local mylauncher = awful.widget.launcher {
        image = beautiful.awesome_icon,
        menu = require "widgets.menu",
    }

    -- Space out my info stuff
    local myinfo = {
        layout = function(...)
            local layout = wibox.layout.fixed.horizontal(...)

            layout.spacing = 10

            return layout
        end,
        require("widgets.mpris").widget,
        require("widgets.screentime").widget,
        require("widgets.sound").widget,
        require("widgets.battery").widget,
        mykeyboardlayout,
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen = s,
        -- height = 16,
        widget = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
                require("widgets.mode").widget,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            {
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    myinfo,
                    wibox.widget.systray(),
                    mytextclock,
                    s.mylayoutbox,
                },
                left = 5,
                widget = wibox.container.margin,
            },
        },
    }
end

-- Force update after a bit bc it fails on boot
gears.timer {
    timeout = 1,
    autostart = true,
    callback = require("widgets.sound").force_update,
    single_shot = true,
}

return create_wibar
