local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local M = {}

-- The current available players
M.players = {}
M.player_names = {}

-- The player controlled by pause/play/stop/etc.
M.current_player = nil

-- Errors with 1 if nothing is currently playing
-- Can return
-- - stopped
-- - paused
-- - playing
--
-- \x1f is ascii unit separator.

M.widget, M.timer = awful.widget.watch(
    "playerctl -a metadata -f '{{playerName}}\x1f{{lc(status)}}\x1f{{title}}'",
    5,
    function(widget, stdout)
        if (stdout):len() == 0 then
            widget.text = ""
            M.current_player = nil
            M.players = {}
            M.player_names = {}
            return
        end

        -- playerctl will pick the first one by default.
        if not M.current_player then
            M.current_player = 1
        end

        -- Substr to ignore the last \n, otherwise we get an empty final string.
        local lines = gears.string.split(stdout:sub(1, -2), "\n")
        for _, line in ipairs(lines) do

            -- TODO: Check if the current player exists in this new batch, if not, then replace with first of this batch.
            --   Store name
            --   If in table, use that index, otherwise set it to 1
            local data = gears.string.split(line, "\x1f")

            M.players[data[1]] = { status = data[2], title = data[3] }
            table.insert(M.player_names, data[1])
        end


        M.update()
    end
)

function M.update()
    -- TODO: Read from beautiful
    local player_name = M.player_names[M.current_player]
    local player = M.players[player_name]
    local color
    if player.status == "playing" then
        color = "#ffffff"
    else
        color = "#aaaaaa"
    end

    -- TODO: Truncate text
    M.widget.markup = ("<span foreground='%s'>[%s] %s</span>"):format(color, gears.string.xml_escape(player_name), gears.string.xml_escape(player.title))
end

--[[ function M.delayed_update(time)
    gears.timer {
        timeout = time or 0.5,
        autostart = true,
        callback = M.update,
        single_shot = true,
    }
end ]]

-- Used to forcefully update the stored data and the text.
function M.force_timer_timeout()
    M.timer:emit_signal("timeout")
end

-- Calls force_timer_timeout after 0.1s. Mpd needs a little bit of time to update.
-- Others may need more time, but I'm more concerned abt mpd.
function M.delayed_timeout()
    gears.timer {
        timeout = 0.2,
        autostart = true,
        callback = M.force_timer_timeout,
        single_shot = true,
    }
end


function M.next_player()
    M.current_player = M.current_player % #M.player_names + 1
    M.update()
end

function M.prev_player()
    M.current_player = (M.current_player - 2) % #M.player_names + 1
    M.update()
end

function M.next()
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "next"}, false)
    M.delayed_timeout()
end

function M.prev()
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "previous"}, false)
    M.delayed_timeout()
end

function M.pause()
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "pause"}, false)
    M.delayed_timeout()
end


function M.play()
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "play"}, false)
    M.delayed_timeout()
end

function M.playpause()
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "play-pause"}, false)
    M.delayed_timeout()
end

-- Used for seeking forward/backward
---@param offset string String of the number of seconds with a + or -
function M.position(offset)
    awful.spawn({"playerctl", "-p", M.player_names[M.current_player], "position", offset}, false)
end



return M
