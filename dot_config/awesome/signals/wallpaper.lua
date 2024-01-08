local beautiful = require "beautiful"
local wibox = require "wibox"
local awful = require "awful"

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        awful.wallpaper {
            screen = s,
            widget = {
                {
                    image     = wallpaper,
                    upscale   = false,
                    downscale = true,
                    widget    = wibox.widget.imagebox,
                },
                valign = "center",
                halign = "center",
                tiled  = false,
                widget = wibox.container.tile,
            }
        }
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("request::wallpaper", set_wallpaper)
