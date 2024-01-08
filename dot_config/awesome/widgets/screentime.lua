local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local usr = require "user"

local M = {}


M.widget = awful.widget.watch(usr.get_script "time_in_seconds.sh", 20, function(_, stdout)
    local seconds = tonumber(stdout)

    M.update(seconds)
end)

M.widget.halign = "center"
M.widget.valign = "center"


local HOUR_S = 60 * 60
local MIN_S = 60

M.update = function(seconds)
    local hours = seconds // HOUR_S
    local minutes = (seconds % HOUR_S) // MIN_S
    M.widget.text = ("%02d:%02d ⏻"):format(hours, minutes)
end

return M
