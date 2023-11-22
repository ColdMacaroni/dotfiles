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

M.watch_widget = awful.widget.watch("acpi", 1, function(_, stdout)
    local status = stdout:gmatch " ([%w%s]+),"()
    local bat = tonumber(stdout:gmatch "(%d+)%%"())

    local remaining = stdout:gmatch "%d%d:%d%d:%d%d"() or "unknown"
    M.tooltip.text = ("%s (%s)"):format(status, remaining)

    M.update(bat, status)
end)

M.widget = wibox.container.margin(M.watch_widget, 5, 5)

M.watch_widget.halign = "center"
M.watch_widget.valign = "center"

M.tooltip = awful.tooltip {
    objects = { M.watch_widget },
}

M.update = function(val, status)
    if not val then
        return
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

    M.watch_widget.markup = ("<span foreground='%s'>%s%% %s</span>"):format(col, val, icon)
end

return M
