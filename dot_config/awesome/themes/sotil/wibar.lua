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
		style = {
			border_width = 2,
			border_color = "#777777",
			shape = gears.shape.circle,
		},
		layout = {
			spacing = 10,
			spacing_widget = {
				{
					visible = false,
					forced_width = 3,
					widget = wibox.widget.separator,
				},
				widget = wibox.container.place,
			},
			layout = wibox.layout.flex.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						visible = false,
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.align.horizontal,
				},
				left = 5,
				right = 5,
				widget = wibox.container.place,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, c, index, objects)
        -- TODO: Show title when focused.
				c:connect_signal("focus", function()
					self:get_children_by_id("text_role")[1]:set_visible(true)
          -- self:set_shape(gears.shape.arrow)(cairo.Con100,100)
				end)

				c:connect_signal("unfocus", function()
					self:get_children_by_id("text_role")[1]:set_visible(false)
          -- self.shape = gears.shape.circle 
				end)
				-- self:get_children_by_id('text_role')[1].visible = c == client.focus
			end,
		},
	})

	--[[ local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		-- style = {
		-- 	shape = gears.shape.circle,
		-- },
		layout = {
			spacing_widget = {
				{
					forced_width = 5,
					forced_height = 24,
					thickness = 1,
					color = "#777777",
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			spacing = 1,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				wibox.widget.base.make_widget(),
				forced_height = 5,
				id = "background_role",
				widget = wibox.container.background,
			},
			{
				awful.widget.clienticon,
				margins = 5,
				widget = wibox.container.margin,
			},
			nil,
			layout = wibox.layout.align.vertical,
		},
		--[[ widget_template = {
			{
				wibox.widget.base.make_widget(),
				forced_height = 5,
				id = "background_role",
				widget = wibox.container.background,
			},
			{
				awful.widget.clienticon,
				margins = 5,
				widget = wibox.container.margin,
			},
			nil,
			layout = wibox.layout.align.vertical,
		}, 
	}) ]]

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
-- return create_wibar
