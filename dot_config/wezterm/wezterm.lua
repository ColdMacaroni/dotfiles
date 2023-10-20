local wezterm = require "wezterm"
local config = {}


config.font_size = 14

config.use_fancy_tab_bar = true
config.enable_scroll_bar = false

-- Kinda vibing
local padx = 48
local pady = 40
config.window_padding = { left = padx, right = padx, top = pady, bottom = pady }

---- Colors
-- Puts the given hex into an rgba
-- set_trans("#ffaaee", "50%") -> "rgba(0xff, 0xaa, 0xee, 50%)"
local function set_trans(color, alpha)
  local r = tonumber(color:sub(2,3), 16)
  local g = tonumber(color:sub(4,5), 16)
  local b = tonumber(color:sub(6,7), 16)

  return ("rgba(%d, %d, %d, %s)"):format(r, g, b, alpha)
end

local theme = "Everblush"
config.color_scheme = theme
local theme_tbl = wezterm.color.get_builtin_schemes()[theme]

config.window_background_opacity = 0.9

-- Tab bar config
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  font = wezterm.font { family = "Cozette" },

  active_titlebar_bg = theme_tbl.ansi[1],
  inactive_titlebar_bg = theme_tbl.ansi[1],
}

config.colors = {
  background = "#0a0a0a",
  -- Highlighter effect.
  selection_fg = "rgba(0,0,0,0%)",
  selection_bg = set_trans(theme_tbl.brights[8], "15%"),

  tab_bar = {
    inactive_tab_edge = theme_tbl.ansi[1],

    active_tab = {
      bg_color = theme_tbl.background,
      fg_color = theme_tbl.foreground,
    },

    inactive_tab = {
      bg_color = theme_tbl.brights[1],
      fg_color = theme_tbl.brights[8],
    },

  },
}

return config
