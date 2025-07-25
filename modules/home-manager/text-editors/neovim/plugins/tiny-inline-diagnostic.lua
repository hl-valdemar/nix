require("tiny-inline-diagnostic").setup({
	-- Style preset for diagnostic messages
	-- Available options:
	-- "modern", "classic", "minimal", "powerline",
	-- "ghost", "simple", "nonerdfont", "amongus"
	preset = "classic",

	-- hi = {
	-- 	error = "DiagnosticError", -- Highlight group for error messages
	-- 	warn = "DiagnosticWarn", -- Highlight group for warning messages
	-- 	info = "DiagnosticInfo", -- Highlight group for informational messages
	-- 	hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
	-- 	arrow = "NonText", -- Highlight group for diagnostic arrows
	--
	-- 	-- Background color for diagnostics
	-- 	-- Can be a highlight group or a hexadecimal color (#RRGGBB)
	-- 	background = "CursorLine",
	--
	-- 	-- Color blending option for the diagnostic background
	-- 	-- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
	-- 	mixing_color = "None",
	-- },

	options = {
		-- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
		show_source = false,

		-- Use icons defined in the diagnostic configuration
		use_icons_from_diagnostic = false,

		-- Add messages to diagnostics when multiline diagnostics are enabled
		-- If set to false, only signs will be displayed
		add_messages = true,

		-- Time (in milliseconds) to throttle updates while moving the cursor
		-- Increase this value for better performance if your computer is slow
		-- or set to 0 for immediate updates and better visual
		throttle = 20,

		-- Minimum message length before wrapping to a new line
		softwrap = 30,

		-- Show all diagnostics under the cursor if multiple diagnostics exist on the same line
		-- If set to false, only the diagnostics under the cursor will be displayed
		multiple_diag_under_cursor = true,

		-- Configuration for multiline diagnostics
		-- Can either be a boolean or a table with the following options:
		--  multilines = {
		--      enabled = false,
		--      always_show = false,
		-- }
		-- If it set as true, it will enable the feature with this options:
		--  multilines = {
		--      enabled = true,
		--      always_show = false,
		-- }
		multilines = {
			-- Enable multiline diagnostic messages
			enabled = true,

			-- Always show messages on all lines for multiline diagnostics
			always_show = true,
		},

		-- Display all diagnostic messages on the cursor line
		show_all_diags_on_cursorline = true,

		-- Enable diagnostics in Insert mode
		-- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
		enable_on_insert = false,

		overflow = {
			-- Manage how diagnostic messages handle overflow
			-- Options:
			-- "wrap" - Split long messages into multiple lines
			-- "none" - Do not truncate messages
			-- "oneline" - Keep the message on a single line, even if it's long
			mode = "wrap",
		},

		-- Configuration for breaking long messages into separate lines
		break_line = {
			-- Enable the feature to break messages after a specific length
			enabled = true,

			-- Number of characters after which to break the line
			after = 60,
		},

		-- Custom format function for diagnostic messages
		-- Example:
		-- format = function(diagnostic)
		--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
		-- end
		format = nil,

		virt_texts = {
			-- Priority for virtual text display
			priority = 2048,
		},

		-- Filter diagnostics by severity
		-- Available severities:
		-- vim.diagnostic.severity.ERROR
		-- vim.diagnostic.severity.WARN
		-- vim.diagnostic.severity.INFO
		-- vim.diagnostic.severity.HINT
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},

		-- Events to attach diagnostics to buffers
		-- You should not change this unless the plugin does not work with your configuration
		overwrite_events = nil,
	},
})

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
})
