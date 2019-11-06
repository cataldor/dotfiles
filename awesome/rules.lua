local awful = require("awful")
local beautiful = require("beautiful")
local bindings = require("bindings")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- @DOC_RULES@
local rules = {
	-- @DOC_GLOBAL_RULE@
	-- All clients will match this rule.
	{ 
		rule = { },
		properties = { 	
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = bindings.clientkeys,
			buttons = bindings.clientbuttons,
			screen = awful.screen.preferred,
			size_hints_honor = false,
			placement = awful.placement.no_overlap +
			    awful.placement.no_offscreen
		}
	},

	-- @DOC_FLOATING_RULE@
	-- Floating clients.
	{ 
		rule_any = {
			instance = {
				"DTA",  -- Firefox addon DownThemAll.
				"copyq",  -- Includes session name in class.
		},
		class = {
			"Arandr",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Wpa_gui",
			"pinentry",
			"veromix",
			"xtightvncviewer"
		},

		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			-- e.g. Google Chrome's (detached) Developer Tools.
			"pop-up",       
		}
	}, 
	properties = { floating = true }},

	-- @DOC_DIALOG_RULE@
	-- Add titlebars to normal clients and dialogs
	{ 
		rule_any = {
			type = { "normal", "dialog" }
		}, 
		properties = { titlebars_enabled = true }
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}
return rules
