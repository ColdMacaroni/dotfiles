local awful = require "awful"
local gears = require "gears"

-- Config file for all user needs.
-- Will be required by the main config,, all directories should end with '/'
local config = {}

config.terminal = "wezterm start"

--  The key with the logo
config.modkey = "Mod4"

-- To run when hitting the edit keybind
config.editor_cmd = config.terminal .. " -e " .. os.getenv "EDITOR"

-- Function used to get the path to scripts.
-- Called like: get_script("screenshot.sh")
local scripts = gears.filesystem.get_configuration_dir() .. "/scripts/"
config.get_script = function(name)
    return scripts .. name
end

-- Function called after everything is required
config.autostart = function()
    awful.spawn(config.get_script "autostart.sh")
end

-- The directory containing the main theme.lua to be passed to beautiful.init
config.theme_dir = gears.filesystem.get_configuration_dir() .. "themes/sotil/"

return config
