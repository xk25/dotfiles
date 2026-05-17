local theme = require("colors")

---------------------------------------
------------- Monitor -----------------
---------------------------------------
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "0x0", scale = 2 })
hl.monitor({ output = "", mode = "preferred", position = "auto-up", scale = 1 })

local terminal = "alacritty"
local fileManager = "nautilus -w"
local menu_alt = "~/.config/rofi/runner.sh"
local menu = "vicinae toggle"
local screenshot = "hyprshot-gui"
local wallpaper = "~/.config/hypr/scripts/set_bg"
local wall_selector = "~/.config/rofi/wall_select/wall_select.sh"
local powermenu = "~/.config/rofi/powermenu/powermenu.sh"
local rofiswitch = "~/.config/rofi/rofi_wswitch"
local clipboard = "vicinae deeplink 'vicinae://launch/clipboard/history?toggle=true'"

hl.on("hyprland.start", function()
	hl.exec_cmd("hypridle")
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("dunst")

	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd(wallpaper)

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4, -- Multi-value margins are passed as strings

		border_size = 2,

		col = {
			-- Uses your Lua color variables inside the table
			active_border = {
				colors = { theme.primary, theme.tertiary },
				angle = 45,
			},
			inactive_border = theme.surface_container_highest,
		},

		resize_on_border = false,
		allow_tearing = true,
		layout = "dwindle",
	},

	decoration = {
		rounding = 7,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 7,
			passes = 4,
			new_optimizations = true,
		},
	},

	cursor = {
		no_hardware_cursors = 0,
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		vrr = 1,
		focus_on_activate = true,
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		accel_profile = "flat",

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.5,
		},
	},
})

---------------------------------------
------------- Animations --------------
---------------------------------------
hl.curve("expressiveFastSpatial", { type = "bezier", points = { { 0.42, 1.67 }, { 0.21, 0.90 } } })
hl.curve("expressiveSlowSpatial", { type = "bezier", points = { { 0.39, 1.29 }, { 0.35, 0.98 } } })
hl.curve("expressiveDefaultSpatial", { type = "bezier", points = { { 0.38, 1.21 }, { 0.22, 1.00 } } })
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("standardDecel", { type = "bezier", points = { { 0, 0 }, { 0, 1 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.52, 0.03 }, { 0.72, 0.08 } } })
hl.curve("stall", { type = "bezier", points = { { 1, -0.1 }, { 0.7, 0.85 } } })

-- Windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "emphasizedDecel", style = "popin 90%" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "emphasizedDecel" })
-- Layers (Commented out legacy mappings converted to Lua comments)
-- hl.animation({ leaf = "layersIn",      enabled = true, speed = 2.7, bezier = "emphasizedDecel", style = "popin 93%" })
-- hl.animation({ leaf = "layersOut",     enabled = true, speed = 2.4, bezier = "menu_accel",       style = "popin 94%" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 0.5, bezier = "menu_decel" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.7, bezier = "stall" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "standardDecel" })

--------- Gestures ---------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--------- Devices ---------
hl.device({
	name = "elan0522:01-04f3:31c3-touchpad",
	sensitivity = 1,
})
hl.device({
	name = "logitech-usb-optical-mouse",
	sensitivity = 1,
})

---------------------------------------
-------------- Keybinds ---------------
---------------------------------------
hl.bind("SUPER + T", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("code"))
hl.bind("SUPER + Z", hl.dsp.exec_cmd("zeditor"))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu_alt))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	-- Switch focus to workspace (SUPER + 1-0)
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move active window to workspace (SUPER + SHIFT + 1-0)
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))

-- Active Window Resizing (Repeating when held)
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Move Current Workspace to a Neighboring Monitor
-- hl.bind("SUPER + CTRL + left", hl.dsp.workspace.move({ direction = "left" }))
-- hl.bind("SUPER + CTRL + right", hl.dsp.workspace.move({ direction = "right" }))
-- hl.bind("SUPER + CTRL + up", hl.dsp.workspace.move({ direction = "up" }))
-- hl.bind("SUPER + CTRL + down", hl.dsp.workspace.move({ direction = "down" }))
-- Mouse Wheel Workspace Switching
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Window Dragging & Resizing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Keyboard Window Movement (Shifting windows left/right/up/down)
hl.bind("SUPER + ALT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + ALT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + ALT + down", hl.dsp.window.move({ direction = "down" }))

hl.bind("SUPER + W", hl.dsp.exec_cmd(wallpaper))
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd(wall_selector))
hl.bind("SUPER + V", hl.dsp.exec_cmd(clipboard))

-- System Session & Application Menus
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("Print", hl.dsp.exec_cmd(screenshot))
hl.bind("SUPER + X", hl.dsp.exec_cmd(powermenu))

-- Status Bar & Workspace Navigation
hl.bind("SUPER + H", hl.dsp.exec_cmd("killall waybar 2>/dev/null || waybar"))
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Network & Bluetooth Management
hl.bind("SUPER + I", hl.dsp.exec_cmd("killall blueman-manager 2>/dev/null || blueman-manager"))
hl.bind("SUPER + ALT + I", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_bluetooth.sh"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("killall nmrs 2>/dev/null || nmrs"))
hl.bind("SUPER + ALT + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_wifi.sh"))

-- Audio Input (Microphone) Mute
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Audio/Brightness Controls via SwayOSD
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -5"), { locked = true, repeating = true })

-- Media Player Controls (Requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

---------------------------------------
-------- Window & Layer Rules ---------
---------------------------------------

--- remove the border if only one window in workspace
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })

hl.window_rule({ match = { initial_title = "^(Open File)$" }, float = true })
hl.window_rule({ match = { title = "^(Choose Files)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })

hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })

hl.window_rule({ match = { class = "^(code)$" }, opacity = "0.90" })
hl.window_rule({ match = { class = "^(dev.zed.Zed)$" }, opacity = "0.90" })
hl.window_rule({ match = { class = "^(org.gnome.Nautilus)$" }, opacity = "0.80" })
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$" }, opacity = "0.85" })
hl.window_rule({ match = { class = "^(org.telegram.desktop)$" }, opacity = "0.85" })
hl.window_rule({ match = { class = "^(Alacritty)$" }, opacity = "0.80" })

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({
	name = "windowrule-16",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0, xray = false, animation = "slidefade top 90%" })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0, xray = false })

hl.window_rule({ name = "hyprshot-gui", match = { title = "^(.*Hyprshot.*)$" }, size = { 200, 200 }, float = true, center = true })

hl.window_rule({
	name = "bluetooth-control",
	match = { class = "^(blueman-manager)$" },
	float = true,
	size = { 400, 400 },
	move = { "monitor_w-window_w+55", "monitor_h-window_h-35" },
	no_max_size = true,
})

hl.window_rule({ name = "sound-control", match = { class = "^(com.saivert.pwvucontrol)$" }, float = true, size = { 400, 800 }, move = { "(monitor_w*1)-window_w-10", "40" } })

hl.window_rule({ name = "network-control", match = { title = "^(.*Network Manager.*)$" }, float = true })
hl.window_rule({ name = "netrs", match = { class = "^(org.nmrs.ui)$" }, float = true, size = { 100, 400 } })

hl.layer_rule({ name = "vicinae-blur", match = { namespace = "vicinae" }, blur = true, ignore_alpha = 0 })
