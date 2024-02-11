local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

local M = {}

M.widget = wibox.widget {
    markup = "",
    halign = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

function M.update(new_mode)
    -- TODO: Pretty colours
    M.widget.markup = "[" .. new_mode .. "]"
end

function M.clear()
    M.widget.markup = ""
end

return M
