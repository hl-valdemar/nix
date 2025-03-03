local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Everforest Dark (Gogh)"
config.enable_tab_bar = false
config.window_background_opacity = 0.92
config.macos_window_background_blur = 50
config.font_size = 14

return config
