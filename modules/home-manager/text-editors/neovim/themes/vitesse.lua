-- Vitesse (Color Scheme)

local M = {}

-- Default options
M.options = {
	transparent = false,
	italic_comments = false,
	bold_keywords = false,
}

-- Define the color palette
M.colors = {
	-- Base colors
	bg = "#121212", -- CORRECTED
	fg = "#bd976a", -- CORRECTED

	-- Normal colors
	black = "#666666", -- CORRECTED
	red = "#CB7676", -- CORRECTED
	green = "#80A665", -- CORRECTED
	yellow = "#BD976A", -- CORRECTED
	blue = "#4C9A91", -- CORRECTED
	magenta = "#674A44", -- CORRECTED
	cyan = "#4D9375", -- CORRECTED
	white = "#677568", -- CORRECTED

	-- Bright colors
	bright_black = "#5c6370",
	bright_red = "#C98A7D", -- CORRECTED
	bright_green = "#80A665", -- CORRECTED
	bright_yellow = "#B7AA65", -- CORRECTED
	bright_blue = "#8fc6f4",
	bright_magenta = "#d7a1e7",
	bright_cyan = "#5EA994", -- CORRECTED
	bright_white = "#677568",

	-- UI specific colors
	gutter_bg = "#121212", -- CORRECTED
	gutter_fg = "#464746", -- CORRECTED
	comment = "#677568", -- CORRECTED
	selection = "#222222", -- CORRECTED
	visual = "#222222", -- CORRECTED
	cursor_line = "#2c323c",
	indent_line = "#3b4048",
	pmenu_bg = "#121212", -- CORRECTED
	pmenu_sel = "#222222", -- CORRECTED

	-- Specialized
	error = "#f44747",
	warning = "#e5c07b",
	info = "#56b6c2",
	hint = "#98c379",

	-- Debug
	invalid_fg = "#ff0000",
	invalid_bg = "#00ff00",
}

-- Setup function with options
function M.setup(opts)
	-- Merge options
	if opts then
		M.options = vim.tbl_deep_extend("force", M.options, opts)
	end

	-- Clear existing highlights
	vim.cmd("highlight clear")

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Set colorscheme name
	vim.g.colors_name = "vitesse"

	-- Load the scheme
	M.load()
end

-- Apply the color scheme
function M.load()
	local c = M.colors
	local o = M.options

	-- Basic UI highlights
	local highlight_groups = {
		-- UI elements
		Normal = { fg = c.fg, bg = o.transparent and "NONE" or c.bg },
		NormalFloat = { fg = c.fg, bg = o.transparent and "NONE" or c.bg },
		StatusLine = { fg = c.fg, bg = c.selection },
		StatusLineNC = { fg = c.gutter_fg, bg = c.gutter_bg },
		VertSplit = { fg = c.indent_line, bg = c.bg },
		Cursor = { fg = c.bg, bg = c.fg },
		CursorLine = { bg = c.cursor_line },
		CursorLineNr = { fg = c.yellow, bold = true },
		LineNr = { fg = c.gutter_fg, bg = o.transparent and "NONE" or c.gutter_bg },
		SignColumn = { fg = c.fg, bg = o.transparent and "NONE" or c.gutter_bg },
		ColorColumn = { bg = c.cursor_line },
		Folded = { fg = c.comment, bg = c.gutter_bg },
		FoldColumn = { fg = c.comment, bg = o.transparent and "NONE" or c.gutter_bg },

		-- Search and selection
		Search = { fg = c.black, bg = c.yellow },
		IncSearch = { fg = c.black, bg = c.yellow },
		Visual = { bg = c.visual },
		VisualNOS = { bg = c.visual },

		-- Popup menus
		Pmenu = { fg = c.fg, bg = c.pmenu_bg },
		PmenuSel = { fg = c.fg, bg = c.pmenu_sel },
		PmenuSbar = { bg = c.pmenu_bg },
		PmenuThumb = { bg = c.fg },

		-- Messages
		ErrorMsg = { fg = c.error },
		WarningMsg = { fg = c.warning },
		MoreMsg = { fg = c.green },
		Question = { fg = c.green },

		-- Diagnostics
		DiagnosticError = { fg = c.error },
		DiagnosticWarn = { fg = c.warning },
		DiagnosticInfo = { fg = c.info },
		DiagnosticHint = { fg = c.hint },

		-- Syntax highlighting
		Comment = { fg = c.comment, italic = o.italic_comments }, -- GOOD
		String = { fg = c.bright_red }, -- GOOD
		Character = { fg = c.bright_red }, -- GOOD
		Number = { fg = c.blue }, -- GOOD
		Float = { fg = c.blue }, -- GOOD
		Boolean = { fg = c.cyan }, -- GOOD

		Identifier = { fg = c.bright_yellow }, -- GOOD
		Function = { fg = c.green }, -- GOOD
		Constant = { fg = c.bright_yellow }, -- GOOD

		Statement = { fg = c.red },
		Conditional = { fg = c.cyan, bold = o.bold_keywords }, -- GOOD
		Repeat = { fg = c.cyan, bold = o.bold_keywords }, -- GOOD
		Label = { fg = c.yellow }, -- GOOD
		Operator = { fg = c.red }, -- GOOD
		Keyword = { fg = c.cyan, bold = o.bold_keywords }, -- GOOD
		Exception = { fg = c.red, bold = o.bold_keywords }, -- GOOD

		PreProc = { fg = c.green }, -- GOOD
		Include = { fg = c.invalid_fg },
		Define = { fg = c.invalid_fg },
		Macro = { fg = c.invalid_fg },
		PreCondit = { fg = c.invalid_fg },

		Type = { fg = c.bright_cyan }, -- GOOD
		StorageClass = { fg = c.invalid_fg },
		Structure = { fg = c.yellow }, -- GOOD
		Typedef = { fg = c.invalid_fg },

		Special = { fg = c.bright_red }, -- GOOD
		SpecialChar = { fg = c.green },
		Tag = { fg = c.invalid_fg },
		Delimiter = { fg = c.black },
		SpecialComment = { fg = c.comment, italic = o.italic_comments }, -- GOOD

		-- Diff
		DiffAdd = { fg = c.green, bg = c.invalid_bg },
		DiffChange = { fg = c.yellow, bg = c.invalid_bg },
		DiffDelete = { fg = c.red, bg = c.invalid_bg },
		DiffText = { fg = c.invalid_fg, bg = c.invalid_bg },

		-- Git
		gitcommitHeader = { fg = c.invalid_fg },
		gitcommitSelectedFile = { fg = c.invalid_fg },
		gitcommitOverflow = { fg = c.invalid_fg },

		-- Spelling
		SpellBad = { sp = c.error, undercurl = true },
		SpellCap = { sp = c.warning, undercurl = true },
		SpellRare = { sp = c.info, undercurl = true },
		SpellLocal = { sp = c.info, undercurl = true },

		-- Terminal colors
		Terminal = { fg = c.fg, bg = c.bg },

		-- File explorer
		Directory = { fg = c.bright_red },
		Title = { fg = c.yellow, bold = true },
	}

	-- Apply highlight groups
	for group, styles in pairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, styles)
	end

	-- Set terminal colors
	vim.g.terminal_color_0 = c.black
	vim.g.terminal_color_1 = c.red
	vim.g.terminal_color_2 = c.green
	vim.g.terminal_color_3 = c.yellow
	vim.g.terminal_color_4 = c.blue
	vim.g.terminal_color_5 = c.magenta
	vim.g.terminal_color_6 = c.cyan
	vim.g.terminal_color_7 = c.white
	vim.g.terminal_color_8 = c.bright_black
	vim.g.terminal_color_9 = c.bright_red
	vim.g.terminal_color_10 = c.bright_green
	vim.g.terminal_color_11 = c.bright_yellow
	vim.g.terminal_color_12 = c.bright_blue
	vim.g.terminal_color_13 = c.bright_magenta
	vim.g.terminal_color_14 = c.bright_cyan
	vim.g.terminal_color_15 = c.bright_white

	-- Plugin specific highlights
	-- Tree-sitter
	highlight_groups["@function"] = { fg = c.green } -- GOOD
	highlight_groups["@method"] = { fg = c.green } -- GOOD
	highlight_groups["@constructor"] = { fg = c.green } -- GOOD
	highlight_groups["@field"] = { fg = c.bright_yellow } -- GOOD
	highlight_groups["@variable"] = { fg = c.yellow } -- GOOD
	highlight_groups["@parameter"] = { fg = c.yellow, italic = false } -- GOOD
	highlight_groups["@keyword"] = { fg = c.red, bold = o.bold_keywords } -- GOOD
	highlight_groups["@string"] = { fg = c.bright_red } -- GOOD
	highlight_groups["@number"] = { fg = c.blue } -- GOOD
	highlight_groups["@boolean"] = { fg = c.cyan } -- GOOD
	highlight_groups["@comment"] = { fg = c.comment, italic = o.italic_comments } -- GOOD
	highlight_groups["@operator"] = { fg = c.red } -- GOOD
	highlight_groups["@lsp.type.enumMember"] = { fg = c.bright_yellow } -- GOOD

	-- Re-apply treesitter highlights
	for group, styles in pairs(highlight_groups) do
		if string.sub(group, 1, 1) == "@" then
			vim.api.nvim_set_hl(0, group, styles)
		end
	end
end

return M
