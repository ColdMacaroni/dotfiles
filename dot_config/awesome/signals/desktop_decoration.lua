local awful = require "awful"
local beautiful = require "beautiful"

-- If the selected theme sets theme.extra.screen_decorations, call that. Otherwise my bar.
local screen_deco = (beautiful.extra and beautiful.extra.screen_decorations)
    or require "widgets.bar"

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

    screen_deco(s)
end)
