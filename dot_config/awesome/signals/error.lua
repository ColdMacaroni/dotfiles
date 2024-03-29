local naughty = require "naughty"
-- This isn't the fallback config so we don't check awesome.startup_errors.
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Your config exploded :(",
            text = tostring(err),
        }
        in_error = false
    end)
end
