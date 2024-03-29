local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

local M = {}

M.icons = {
    Discharging = {
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        -- "",
        "",
        -- "",
        "",
    },
    Charging = "",

    Unknown = "",
    Full = "",
    ["Not charging"] = "",
}

M.widget = awful.widget.watch("acpi", 1, function(_, stdout)
    local status = stdout:gmatch " ([%w%s]+),"()
    local bat = tonumber(stdout:gmatch "(%d+)%%"())

    local remaining = stdout:gmatch "%d%d:%d%d:%d%d"() or "unknown"
    M.tooltip.text = ("%s (%s)"):format(status, remaining)

    M.update(bat, status)
end)

M.widget.halign = "center"
M.widget.valign = "center"

M.tooltip = awful.tooltip {
    objects = { M.widget },
}

M.update = function(val, status)
    if not val then
        return
    end

    -- Shutdown computer when very low
    -- Better this than unexpected shutdown
    if val <= 3 and status ~= "Charging" then
        awful.spawn("poweroff")
    end

    -- TODO: ADD COLOURS TO THEME
    local col = beautiful.extra.battery[status]

    if val <= 20 and status ~= "Charging" then
        col = beautiful.extra.battery.Low
    end

    local icon = M.icons[status]

    -- Pick icon based on range
    if type(icon) == "table" then
        icon = icon[math.ceil(val / 100 * #icon)]
    end

    M.widget.markup = ("<span foreground='%s'>%s%% %s</span>"):format(col, val, icon)
end

return M
