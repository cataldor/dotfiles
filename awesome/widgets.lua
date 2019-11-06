local beautiful = require ("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")

local global = require("global")

local widgets = {
	memwidget_icon = wibox.widget.imagebox(
				global.theme_dir .. "/icons/mem.png"),
	mpdicon = wibox.widget.imagebox(),
	uptime_icon = wibox.widget.imagebox(
				global.theme_dir .. "/icons/load_awe.png"),
	cpuwidget_icon = wibox.widget.imagebox(
				global.theme_dir .. "/icons/cpu.png"),
	volumewidget_icon = wibox.widget.imagebox(
				global.theme_dir .. "/icons/spkr.png"),
	netwidget_up_icon = wibox.widget.imagebox(
				global.theme_dir .. "/icons/net_up.png")
}

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- {{{ memwidget
-- cataldo: create mem widget
-- linux:
-- $1 - memory usage in percentage
-- $2 - memory usage
-- $3 - total system memory
-- $4 - free memory
-- $5 - swap usage in percentage
-- $6 - swap usage
-- $7 - total system swap
-- $8 - free swap
-- $9 - memory usage + buffers and caches
widgets.memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(widgets.memwidget, vicious.widgets.mem, 
    '<span color="#fff700">$2M swap $5% </span>', 
13)
--- }}}

--- {{{ mpd
widgets.mpdwidget = wibox.widget.textbox()
vicious.register(widgets.mpdwidget, vicious.widgets.mpd,
function(widget, args)
	if args["{state}"] == "Stop" then
		widgets.mpdicon._private.image = nil
		widgets.mpdicon:emit_signal("widget::redraw_needed")
		widgets.mpdicon:emit_signal("widget:layout_changed")
		return ""
	else
		widgets.mpdicon:set_image(
				global.theme_dir .. "/icons/note_on.png")
		return '<span color="#e43c62">' ..args["{Artist}"]..
			' > </span>' ..args["{Title}"]
	end
end, 21)
--- }}}

-- {{{ load
widgets.uptimewidget = wibox.widget.textbox()
vicious.register(widgets.uptimewidget, vicious.widgets.uptime,
function(widget, args)
	return(string.format('<span color="#ff7ef2"> %2.2f %2.2f %2.2f </span>',
 	    args[4], args[5], args[6]))
end, 61)
--- }}}

-- {{{ CPU
widgets.cpuwidget = wibox.widget.textbox()
vicious.register(widgets.cpuwidget, vicious.widgets.cpu,
function(widget, args)
	local ptos = {}
	local cpu_s = "cpu"
	local count = 1
	-- XXX: string buffer?
	local s = ""

	ptos[0] = '#B8EAC6'
	ptos[1] = '#00C0FF'
	ptos[2] = '#00FF5F'
	ptos[3] = '#FF00FF'
	ptos[4] = '#FF000A'
	for _ in pairs(args) do
		if count <= 1 then
			s = s .. string.format("%s", "Avg: ")
			s = s .. 
			    string.format("<span color='%s'>[%02.0f] </span>", 
			    ptos[args[count]//25], args[count])
		elseif args[count] < 20 then
			goto continue
		else
			s = s .. string.format("CPU%d ", count - 2)
			s = s .. string.format("<span color='%s'>[%02.0f]", 
			    ptos[args[count]//25], args[count])
			s = s .. string.format("-%.3s </span>",
				vicious.call(vicious.widgets.cpufreq, "$2",
				cpu_s .. (count - 2))) 
		end

::continue::
		count = count + 1
	end
	return(s)
end, 11)
--- }}}

-- {{{ volume
widgets.volumewidget = wibox.widget.textbox()
vicious.register(widgets.volumewidget, vicious.widgets.volume,
function(widget, args)
	return(string.format("<span color='#7493D2'>%s%%</span>", args[1]))
end, 17, "Master")
-- }}}

-- {{{ net
--netwidget_down_icon = wibox.widget.imagebox(
--				global.theme_dir .. "/icons/net_down.png")
widgets.netwidget = wibox.widget.textbox()
vicious.register(widgets.netwidget, vicious.widgets.net,
function(widget, args)
	local e = ""
	local s = ""

	for i = 1, #global.eths do
		e = global.eths[i]
		if args["{" .. e .. " carrier}"] == 1 then
			s = string.format("%s dw [%.0f] up [%.0f]",
			    s, args['{' .. e.. ' down_kb}'],
			    args['{' .. e .. ' up_kb}'])
		end
	end

	return(s)
end, 4)
-- }}}

-- {{{ dio
widgets.diowidget = wibox.widget.textbox()
vicious.register(widgets.diowidget, vicious.widgets.dio,
function(widget, args)
	local s = ""
	local read = ""
	local write = ""

	for i = 1, #global.dios do
		read = tonumber(args['{' .. global.dios[i] .. ' read_kb}']) or 0
		write = tonumber(args['{' .. global.dios[i] .. ' write_kb}']) or 
			0
		if read > 10 or write > 10 then
			s = string.format("%s <span color='#FF7200'>%s</span>", 
					  s, global.dios_nick[i])
		end
		if read > 10 then
			s = string.format("%s r[%.f] kbps", s, read)
		end
		if write > 10 then
			s = string.format("%s w[%.f] kbps", s, write)
		end
	end
	return(s)
end, 9)
-- }}}

-- {{{ batt
widgets.battwidget = wibox.widget.textbox()
if global.hostname == "xenomorph" then
	vicious.register(widgets.battwidget, vicious.widgets.bat,
	function(widget, args)
		local s = ""

		 s = string.format("bat: [%s, %s]", args[1], args[2])
		 return(s)
	end, 63, "BAT1")
end
-- }}}
--
-- {{{ cpu usage
widgets.cpu_usage = wibox.widget.textbox()
vicious.register(widgets.cpu_usage, vicious.widgets.cpu, 
function(widget, args)
	local usage_cnt = 1
	local name_cnt = 3
	local name_f = ""
	local usage_f = ""
	local name_s = ""
	local usage_s = ""
	local line = ""
	local p = io.popen("top -b -o %CPU | head -n 9 | tail -n 2")

	line = p:read("l")
	for word in string.gmatch(line, "%s%a+") do
		name_cnt = name_cnt - 1
		if name_cnt == 0 then
			name_f = word
		end
	end
	for nm in string.gmatch(line, "%d+%.%d+%s") do
		usage_cnt = usage_cnt - 1
		if usage_cnt == 0 then
			usage_f = nm
		end
	end

	name_cnt = 3
	usage_cnt = 1
	line = p:read("l")
	for word in string.gmatch(line, "%s%a+") do
		name_cnt = name_cnt - 1
		if name_cnt == 0 then
			name_s = word
		end
	end
	for nm in string.gmatch(line, "%d+%.%d+%s") do
		usage_cnt = usage_cnt - 1
		if usage_cnt == 0 then
			usage_s = nm
		end
	end

	s = string.format("[%s %s, %s %s]", name_f:sub(2), usage_f:sub(1, -2), 
	     name_s:sub(2), usage_s:sub(1, -2))
	p:close()
	p = nil
	return(s)
end, 17)
-- }}}

-- {{{ File system usage
--fsicon = wibox.widget.imagebox(beautiful.widget_fs)
-- Initialize widgets
widgets.fs = {
	b_pre = wibox.widget.textbox("/boot "),
	b = wibox.widget.textbox(), 
	b_pb = wibox.widget.progressbar(),
	r_pre = wibox.widget.textbox("root "),
	r = wibox.widget.textbox(),
	r_pb = wibox.widget.progressbar(),
	h_pre = wibox.widget.textbox("/home "),
	h = wibox.widget.textbox(), 
	h_pb = wibox.widget.progressbar(),
	--s = wibox.widget.textbox()
}
widgets.fs.b_pb.background_color = '#3F3F3F'
widgets.fs.h_pb.background_color = '#3F3F3F'
widgets.fs.r_pb.background_color = '#3F3F3F'

widgets.fs.b_pb.forced_width = 50
widgets.fs.h_pb.forced_width = 50
widgets.fs.r_pb.forced_width = 50

widgets.fs.b_pb.border_color = '#ffffff'
widgets.fs.b_pb.border_width = 0.5
widgets.fs.h_pb.border_color = '#ffffff'
widgets.fs.h_pb.border_width = 0.5
widgets.fs.r_pb.border_color = '#ffffff'
widgets.fs.r_pb.border_width = 0.5

-- Register widgets
vicious.register(widgets.fs.b, vicious.widgets.fs, " ${/boot avail_gb} GiB", 181)
vicious.register(widgets.fs.b_pb, vicious.widgets.fs, "${/boot used_p}", 181)
vicious.register(widgets.fs.r, vicious.widgets.fs, " ${/ avail_gb} GiB",     182)
vicious.register(widgets.fs.r_pb, vicious.widgets.fs, "${/ used_p}",     182)
vicious.register(widgets.fs.h, vicious.widgets.fs, " ${/home avail_gb} GiB", 183)
vicious.register(widgets.fs.h_pb, vicious.widgets.fs, "${/home used_p}", 183)
--vicious.register(fs.s, vicious.widgets.fs, "${/mnt/storage used_p}", 599)
-- }}}

return widgets

