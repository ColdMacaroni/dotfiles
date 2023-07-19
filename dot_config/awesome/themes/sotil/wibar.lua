-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- This needs to be just a table because it's dynamically created.
function create_wibar(beautiful, s)
	--[[
    {
        {
            {
                text = "foo",
                widget = wibox.widget.textbox
            },
            {
                text = "bar",
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.vertical
        },
        bg = "#ff0000",
        widget = wibox.container.background
    }
  ]]

	-- It just refuses the work inside the table.
	local taglist = awful.widget.taglist({
		id = "taglist",
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = wibox.layout.flex.horizontal,
	})

	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
	})

	local M = {
		{
			{
				taglist,
				layout = wibox.layout.fixed.horizontal,
				screen = s,
				bg = beautiful.bg_normal,
			},
			layout = wibox.layout.fixed.horizontal,
		},

		{
			tasklist,
			screen = s,
			layout = wibox.layout.fixed.horizontal,
		},
		nil,

		layout = function()
			local l = wibox.layout.align.horizontal()
			l.expand = "outside"
			return l
		end,
		id = "main",
		screen = s,
	}

	return M
end

-- Temp nil return to not mess up my awesome
return create_wibar
