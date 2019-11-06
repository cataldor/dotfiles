local global = {
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with
-- others.
	modkey 		= "Mod4",
	terminal	= "xterm",
	editor		= os.getenv("EDITOR") or "vim",
}

global.editor_cmd = global.terminal .. " -e " .. global.editor

global.theme_dir = os.getenv("HOME") .. "/.config/awesome/awesome-copycats/" ..
				 "themes/multicolor"
-- get hostname
local f = io.open("/etc/hostname", "r")
global.hostname = f:read "l"
f:close()
---

--- set available network interfaces
global.eths = {}
if hostname == "xenomorph" then
	global.eths = { 'wlp3s0' }
else
	global.eths = { 'eno1', 'enp1s0' }
end
---

-- set available disks
global.dios_nick = { '/', '/home' }
global.dios = {}
if hostname == "xenomorph" then
	global.dios = { 'sdb3', 'sdb4' }
else
	global.dios = { 'sda3', 'sdb'}
end
---
return global
