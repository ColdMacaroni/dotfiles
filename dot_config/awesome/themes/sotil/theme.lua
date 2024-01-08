---------------------------
----    Sotil Theme    ----
---------------------------
--- Beautiful docs at https://awesomewm.org/doc/api/libraries/beautiful.html

-- Load system things
local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi

local theme_name                                = "sotil"

-- Get this folder's path. Should be in awesomewm's config folder.
-- I can't find a better way of doing this
local gfs                                       = require("gears.filesystem")
local theme_path                                = gfs.get_configuration_dir() .. "themes/" .. theme_name .. "/"

local theme                                     = {}

theme.font                                      = "Cozette 8"

-- I'm using

theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#5a5180"
theme.bg_urgent                                 = "#DE494D"
theme.bg_minimize                               = "#333333"
theme.bg_systray                                = theme.bg_normal
theme.bg_systray                                = "#352025"  -- "#b7a7ba"
theme.bg_wibar                                  = "#00000000"

theme.fg_normal                                 = "#bababa"
theme.fg_focus                                  = "#ffffff"
theme.fg_urgent                                 = "#ffffff"
theme.fg_minimize                               = "#ffffff"

theme.useless_gap                               = dpi(0)
theme.border_width                              = dpi(1)
theme.border_normal                             = "#000000"
theme.border_focus                              = "#534d6f"
theme.border_marked                             = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_bg_empty                        = theme.bg_normal
theme.taglist_fg_empty                        = "#aaaaaa"

theme.taglist_bg_occupied                     = theme.bg_normal
theme.taglist_fg_occupied                     = "#aaaaaa"
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]

-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_font = "Cozette 8"
theme.hotkeys_description_font = "Cozette 8"
theme.hotkeys_opacity = 0.9
theme.hotkeys_modifiers_fg = "#8ccf7e"
theme.hotkeys_fg = "#dadada"
theme.hotkeys_bg = "#141b1e"
theme.hotkeys_border_color = "#232a2d"
theme.hotkeys_border_width = 2
theme.hotkeys_label_fg = "#6cbfbf"
theme.hotkeys_label_bg = theme.hotkeys_bg
theme.hotkeys_group_margin = 20

-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size                       = dpi(4)
theme.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-------------------
-- Notifications --
-------------------
-- See https://awesomewm.org/doc/api/libraries/naughty.html

-- Variables set for theming notifications:
theme.notification_font                         = "sans 14"
-- notification_[bg|fg]

theme.notification_bg                           = theme.bg_normal .. "e0"
theme.notification_fg                           = "#e7e7e7"
-- notification_[width|height|margin]

-- Increase padding
theme.notification_margin                       = 10

-- SIze settings

theme.notification_icon_size                    = dpi(64)
theme.notification_max_width                    = 500

-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon                         = theme_path .. "submenu.png"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(145)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = theme_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme_path .. "titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = theme_path .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme_path .. "titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = theme_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme_path .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = theme_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme_path .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = theme_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme_path .. "titlebar/maximized_focus_active.png"

theme.wallpaper                                 = theme_path .. "wallpaper"
-- Stack of wallpapers for each screen.
-- local wallpapers = { os.getenv("HOME") .. "/pictures/squarecry.png"  ,"/usr/share/backgrounds/celeste_campfire.jpg" }
-- theme.wallpaper                                 = function(_)
--     local wall = wallpapers[#wallpapers]
--     if #wallpapers > 1 then
--         wallpapers[#wallpapers] = nil
--     end
--
--     return wall
-- end

-- You can use your own layout icons like this:
theme.layout_fairh                              = theme_path .. "layouts/fairhw.png"
theme.layout_fairv                              = theme_path .. "layouts/fairvw.png"
theme.layout_floating                           = theme_path .. "layouts/floatingw.png"
theme.layout_magnifier                          = theme_path .. "layouts/magnifierw.png"
theme.layout_max                                = theme_path .. "layouts/maxw.png"
theme.layout_fullscreen                         = theme_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom                         = theme_path .. "layouts/tilebottomw.png"
theme.layout_tileleft                           = theme_path .. "layouts/tileleftw.png"
theme.layout_tile                               = theme_path .. "layouts/tilew.png"
theme.layout_tiletop                            = theme_path .. "layouts/tiletopw.png"
theme.layout_spiral                             = theme_path .. "layouts/spiralw.png"
theme.layout_dwindle                            = theme_path .. "layouts/dwindlew.png"
theme.layout_cornernw                           = theme_path .. "layouts/cornernww.png"
theme.layout_cornerne                           = theme_path .. "layouts/cornernew.png"
theme.layout_cornersw                           = theme_path .. "layouts/cornersww.png"
theme.layout_cornerse                           = theme_path .. "layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

--- NON-AWESOME PROPERTIES ---
-- I use these to define my own stuff. They'll be in the table extra
theme.extra = {
    -- screen_decorations = function(s)
    --     -- Do per-screen stuff like bar, widgets, etc
    -- end

    -- The colour of the battery widget
    battery = {
        Low = "#f44761", -- <=20
        Discharging = theme.fg_normal,
        Charging = "#58df67",
        Unknown = "#e9e554",
        Full = "#fdc7b2",
        ["Not charging"] = "#e9e554",
    },

    sound = { normal = theme.fg_normal, muted = "#f44761" }
}
-------------------------------

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
