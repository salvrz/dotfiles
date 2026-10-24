-- [[ Autostart Settings ]]
--
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd(terminal .. " -e btm --theme=gruvbox-light")
end)
