-- @DOC_REQUIRE_SECTION@
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- plugins
local vicious = require("vicious")
local lain = require("lain")

-- user library
local global = require("global")
local bindings = require("bindings")
local menu = require("menu")
local rules = require("rules")
local wg = require("widgets")

--- update times for widgets
-- mem: 13s
-- mpd: 21s
-- load: 61s
-- cpu: 11s
-- volume: 17s
-- net: 4s
-- disk IO: 9s
-- top: 17s
-- disk avail: 181s, 182s, 183s
-- batt (when avail): 63s
-- cpu usage: 17s
---

-- {{{ Error handling
-- @DOC_ERROR_HANDLING@
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
		       title = "Oops, there were errors during startup!",
		       text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error",
	function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
			       title = "Oops, an error happened!",
                               text = tostring(err) })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- @DOC_LAYOUT@
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

mymainmenu = awful.menu(
{ 
	items = 
	{
		{ "awesome", 
		    menu.myawesomemenu, beautiful.awesome_icon },

		{ "open terminal", 
		    global.terminal },

		{ "fix monitor", 
		function() 
			awful.spawn("xterm -e xrandr --output HDMI1 --auto "
				     ..	"--output HDMI3 --auto --left-of HDMI1")
		end },

		{ "fix caps",
		function()
			awful.spawn("xterm -e setxkbmap -option caps:super")
		end},

		{ "intl keyboard",
		function()
			awful.spawn("xterm -e setxkbmap -layout us -variant intl")
		end},

		{ "us keyboard",
		function()
			awful.spawn("xterm -e setxkbmap -layout us")
		end}
	}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
-- Set the terminal for apps that require it
menubar.utils.terminal = global.terminal

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Separators
--local spr     = wibox.widget.textbox(' ')
local arrl_dl = lain.util.separators.arrow_left("#313131", "alpha")
local arrl_ld = lain.util.separators.arrow_left("alpha", "#313131")
-- BOTTOM wibox
--local separator = wibox.widget.textbox("<span color='#A9D7F2'> ~~ </span>")

-- hostname
hostwidget = wibox.widget.textbox(string.format("%s ", global.hostname))

-- sys
syswidget = wibox.widget.textbox()
vicious.register(syswidget, vicious.widgets.os, "$2")

-- Create a wibox for each screen and add it

-- @DOC_WALLPAPER@
local function set_wallpaper(s)
-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- @DOC_FOR_EACH_SCREEN@
awful.screen.connect_for_each_screen(
function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6"}, s, awful.layout.layouts[2])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating
	-- which layout we're using.

	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1,
			   function()
				   awful.layout.inc( 1)
			   end),

                           awful.button({ }, 3,
			   function()
				   awful.layout.inc(-1)
			   end),

                           awful.button({ }, 4,
			   function()
				   awful.layout.inc( 1)
			   end),

                           awful.button({ }, 5,
			   function()
				   awful.layout.inc(-1)
			   end))
			   )
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all,
	bindings.taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, 
	awful.widget.tasklist.filter.currenttags, tasklist_buttons)

	-- @DOC_WIBAR@
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- @DOC_SETUP_WIDGETS@
	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
			wg.volumewidget_icon,
			wg.volumewidget,
			wg.mpdicon,
			wg.mpdwidget,
		},
		--s.mytasklist, -- Middle widget
		nil,
		{ 
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.container.background(wg.battwidget, "#313131"),
			arrl_dl,
			wibox.container.background(wg.diowidget, "#000000"),
			arrl_ld,
			wibox.container.background(wg.netwidget_up_icon, "#313131"),
			wibox.container.background(wg.netwidget, "#313131"),
			arrl_dl,
			wibox.container.background(wg.cpuwidget_icon, "#000000"),
			wibox.container.background(wg.cpuwidget, "#000000"),
			arrl_ld,
			wibox.container.background(wg.memwidget_icon, "#313131"),
			wibox.container.background(wg.memwidget, "#313131"),
			--uptime_icon,
			arrl_dl,
			wibox.container.background(wg.uptimewidget, "#000000"),
			arrl_ld,
			wibox.container.background(mykeyboardlayout, "#313131"),
			arrl_dl,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	}

	-- bottom wibox
	s.mywibox_bottom = awful.wibar({ position = "bottom", screen = s, 
	height = 12 })

	s.mywibox_bottom:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.container.background(hostwidget, "#000000"),
			wibox.container.background(syswidget, "#000000"),
			arrl_ld,
			wibox.container.background(wg.fs.b_pre, "#313131"),
			wibox.container.background(wg.fs.b_pb, "#313131"),
			wibox.container.background(wg.fs.b, "#313131"),
			arrl_dl,
			wibox.container.background(wg.fs.h_pre, "#000000"),
			wibox.container.background(wg.fs.h_pb, "#000000"),
			wibox.container.background(wg.fs.h, "#000000"),
			arrl_ld,
			wibox.container.background(wg.fs.r_pre, "#313131"),
			wibox.container.background(wg.fs.r_pb, "#313131"),
			wibox.container.background(wg.fs.r, "#313131"),
			arrl_dl,
			wibox.container.background(wg.cpu_usage, "#000000"),
		},
		--nil,
		--nil,
	}
end)
-- }}}

awful.rules.rules = rules

-- {{{ Signals
-- Signal function to execute when a new client appears.
-- @DOC_MANAGE_HOOK@
client.connect_signal("manage",
function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and
	    not c.size_hints.user_position
	    and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count 
		-- changes.
		awful.placement.no_offscreen(c)
	end
end)

-- @DOC_TITLEBARS@
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({ }, 1,
		function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),

		awful.button({ }, 3,
		function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c): setup {
        {
		-- Left
		awful.titlebar.widget.iconwidget(c),
		buttons = buttons,
		layout  = wibox.layout.fixed.horizontal
        },
        { 
		-- Middle
		{
			-- Title
			align  = "center",
			widget = awful.titlebar.widget.titlewidget(c)
		},
		buttons = buttons,
		layout  = wibox.layout.flex.horizontal
        },
        { 
		-- Right
		awful.titlebar.widget.floatingbutton (c),
		awful.titlebar.widget.maximizedbutton(c),
		awful.titlebar.widget.stickybutton   (c),
		awful.titlebar.widget.ontopbutton    (c),
		awful.titlebar.widget.closebutton    (c),
		layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
	}
end)

-- Set keys
root.keys(bindings.keyboard)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
function(c)
	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
	    and awful.client.focus.filter(c) then
		client.focus = c
	end
end)

 --toggle title bars if client is floating
client.connect_signal("property::floating",
function(c)
	if c.floating then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end)

-- @DOC_BORDER@
client.connect_signal("focus",
function(c)
	c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus",
function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}
