-- set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use the system clipboard
vim.o.clipboard = "unnamedplus"

-- set line numbers in the gutter
vim.o.number = true
vim.o.relativenumber = true

-- always show the sign column to avoid horizontal jitter
vim.o.signcolumn = "yes"

-- tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- refresh time in millis
vim.o.updatetime = 300

-- enable 24-bit colour
vim.o.termguicolors = true

-- enable the mouse
vim.o.mouse = "a"

-- disable swap files!
vim.o.swapfile = false

-- disable mode indicator since i'm using lualine
vim.o.showmode = false

-- set border style
vim.o.winborder = "single"

-- set the color scheme
-- vim.cmd("colorscheme everforest")
-- require("vitesse").setup({
-- 	-- Your options
-- 	transparent = true,
-- 	italic_comments = false,
-- })

-- enable background transparency
--vim.cmd([[
--    highlight Normal guibg=none
--    highlight NonText guibg=none
--    highlight NormalNC guibg=none
--    highlight Normal ctermbg=none
--    highlight NonText ctermbg=none
--    highlight NormalNC ctermbg=none
--]])

-- syntax highlighting for MQL5
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mq5",
	command = "set filetype=cpp",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mqh",
	command = "set filetype=cpp",
})

-- Create the toggle function in the global scope for easier access
function _G.toggle_float_term()
	-- Check if we already have a terminal window reference
	if vim.g.term_win and vim.api.nvim_win_is_valid(vim.g.term_win) then
		-- Close the window if it exists
		vim.api.nvim_win_close(vim.g.term_win, true)
		vim.g.term_win = nil
	else
		-- Calculate dimensions
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)
		local col = math.floor((vim.o.columns - width) / 2)
		local row = math.floor((vim.o.lines - height) / 2)

		-- Create window options
		local opts = {
			relative = "editor",
			width = width,
			height = height,
			col = col,
			row = row,
			style = "minimal",
			border = "double",
		}

		-- Create or reuse the buffer
		if not vim.g.term_buf or not vim.api.nvim_buf_is_valid(vim.g.term_buf) then
			vim.g.term_buf = vim.api.nvim_create_buf(false, true)
		end

		-- Create the window and open terminal
		vim.g.term_win = vim.api.nvim_open_win(vim.g.term_buf, true, opts)

		-- Only start terminal if it's not already one
		if vim.bo[vim.g.term_buf].buftype ~= "terminal" then
			vim.fn.termopen(vim.o.shell)
			vim.cmd("startinsert")
		end
	end
end

-- Map leader+f to the global function
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _G.toggle_float_term()<CR>", { noremap = true, silent = true })

-- Use Shift+Escape to exit terminal mode
vim.api.nvim_set_keymap("t", "<S-Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Configuration
local poll_interval_ms = 1000 -- Poll once per second
local previous_os_mode = nil -- Track last detected mode

-- Function to detect macOS appearance
local function get_os_theme_mode()
	local cmd = "/usr/bin/defaults read -g AppleInterfaceStyle 2>/dev/null"
	local output = vim.fn.system(cmd)
	local success = vim.v.shell_error == 0

	if success and output:match("Dark") then
		return "dark"
	else
		return "light"
	end
end

-- Function that only updates the background option
local function update_background_from_os_theme()
	-- Add error handling
	local ok, detected_mode = pcall(get_os_theme_mode)
	if not ok then
		vim.notify("Error detecting OS theme: " .. tostring(detected_mode), vim.log.levels.ERROR)
		return
	end

	-- Only update if the mode changed
	if detected_mode ~= previous_os_mode then
		vim.notify("OS theme changed to " .. detected_mode, vim.log.levels.INFO)
		vim.o.background = detected_mode
		previous_os_mode = detected_mode
	end
end

-- Initialize on startup
local ok, initial_mode = pcall(get_os_theme_mode)
if ok then
	previous_os_mode = initial_mode
	vim.o.background = initial_mode
else
	vim.notify("Error detecting initial OS theme", vim.log.levels.ERROR)
end

-- Set up the timer in global scope to prevent garbage collection
if _G.theme_timer and not _G.theme_timer:is_closing() then
	_G.theme_timer:close()
end

_G.theme_timer = vim.loop.new_timer()
if _G.theme_timer then
	_G.theme_timer:start(
		poll_interval_ms,
		poll_interval_ms,
		vim.schedule_wrap(function()
			pcall(update_background_from_os_theme)
		end)
	)
else
	vim.notify("Failed to create theme polling timer", vim.log.levels.ERROR)
end

-- User commands for manual control
vim.api.nvim_create_user_command("SyncOsTheme", function()
	pcall(update_background_from_os_theme)
end, {})

vim.api.nvim_create_user_command("StopThemePolling", function()
	if _G.theme_timer and not _G.theme_timer:is_closing() then
		_G.theme_timer:close()
		vim.notify("Theme polling stopped", vim.log.levels.INFO)
	else
		vim.notify("Theme polling is not active", vim.log.levels.INFO)
	end
end, {})

vim.api.nvim_create_user_command("StartThemePolling", function()
	if _G.theme_timer and not _G.theme_timer:is_closing() then
		vim.notify("Theme polling is already active", vim.log.levels.INFO)
	else
		_G.theme_timer = vim.loop.new_timer()
		_G.theme_timer:start(
			poll_interval_ms,
			poll_interval_ms,
			vim.schedule_wrap(function()
				pcall(update_background_from_os_theme)
			end)
		)
		vim.notify("Theme polling started", vim.log.levels.INFO)
	end
end, {})

local function apply_colorscheme()
	-- Clear existing highlights to prevent bleed-through
	vim.cmd("hi clear")

	if vim.o.background == "dark" then
		local vitesse = require("vitesse")
		vitesse.setup({
			transparent = true,
			italic_comments = false,
		})
		-- vim.cmd("colorscheme habamax")
	else
		-- Light theme
		vim.cmd("colorscheme everforest")
	end

	-- Force redraws to ensure complete refresh
	vim.cmd("redraw!")
end

-- Then add the autocommand for theme switching separately
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = apply_colorscheme,
})

-- apply the colorscheme on startup
apply_colorscheme()
