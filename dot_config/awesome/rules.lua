local awful = require "awful"
local ruled = require "ruled"

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            -- XXX: Uncomment?
            -- border_width = beautiful.border_width,
            -- border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    }

    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "mpv",
                "Pqiv",
                "feh",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        },
    }

    -- No titlebars tyvm
    ruled.client.append_rule {
        id = "titlebars",
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false },
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    ruled.client.append_rule {
        rule = { class = "firefox" },
        callback = function(c)
            -- Probably move to own function
            for _, client in ipairs(client.get()) do
                if c.class == client.class and c ~= client then
                    return
                end
            end

            -- XXX: Change to use indexed awful.tags or smth
            --      or try to find tag name firefox/www and then nil
            local tag = awful.tag.find_by_name(nil, "2")
            c:move_to_tag(tag)
        end,
    }
end)

ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        },
    }
end)
