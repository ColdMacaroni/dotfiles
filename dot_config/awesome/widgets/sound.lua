local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

local M = {}

M.icons = {
    normal = { "奄", "奔", "墳" },
    muted = "婢",
}

M.widget, M.timer = awful.widget.watch("wpctl get-volume @DEFAULT_AUDIO_SINK@", 5, function(_, stdout)
    local vol = tonumber(stdout:gmatch "([%d\\.]+)"()) * 100
    local ismuted = not not stdout:gmatch "MUTED"()

    M.update(vol, ismuted)
end)

M.widget:add_button(awful.button({}, awful.button.names.LEFT, function() awful.spawn("pavucontrol") end))

M.widget.halign = "center"
M.widget.valign = "center"

M.force_update = function() M.timer:emit_signal("timeout") end

M.update = function(volume, muted)
    if not volume then
        return
    end

    local col = muted and beautiful.extra.sound.muted or beautiful.extra.sound.normal

    local icon


    -- Pick icon based on range
    if muted then
        icon = M.icons.muted
    else
        icon = M.icons.normal[math.ceil(volume / 100 * #M.icons.normal)]
    end

    M.widget.markup = ("<span foreground='%s'>%.0f%% %s</span>"):format(col, volume, icon)
end

return M
