-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require "gears"
local awful = require "awful"

-- I think this is deprecated
require "awful.autofocus"

local menubar = require "menubar"

-- Load this early in case anything else breaks.
require "signals.error"

-- Returns a table with options likely to be changed often
local usr = require "user"

----- Create globals
-- Should these be put into a table like:
-- G = {}   ?
-- Should I even be using globals?
-- They're just 2 and common stuff so I'm willing to just leave them be
modkey = usr.modkey
terminal = usr.terminal
-----

-- Apply theme settings
require "theme"

-- Create all keybinds
require "binds"

-- Declare rules
require "rules"

-- Load signals
require "signals"

-- Menubar configuration (From the default, not sure where else to put it)
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

if usr.autostart then
    usr.autostart()
end

-- vim: errorformat=ERROR\:\ %f\:%l\:\ %m
-- recommend :set makeprg=awesome\ -k\ -c\ %
-- You can then do :make to test for syntax errors.
