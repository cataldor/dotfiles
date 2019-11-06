local awful = require("awful")
local beautiful = require("beautiful")

local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local global = require("global")

local awesome = _G.awesome
local menu = {}

--{{{ Menu
--@DOC_MENU@
--Create a launcher widget and a main menu
menu.myawesomemenu = {
	{ "hotkeys",
	function()
		return false, hotkeys_popup.show_help
	end},

	{ "manual",
	global.terminal .. " -e man awesome" },

	{ "edit config",
	global.editor_cmd .. " " .. awesome.conffile },

	{ "restart",
	awesome.restart },

	{ "quit",
	function()
		awesome.quit()
	end}
}

return menu
