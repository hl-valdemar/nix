-- { "┌", "FloatBorder" },
-- { "─", "FloatBorder" },
-- { "┐", "FloatBorder" },
-- { "│", "FloatBorder" },
-- { "┘", "FloatBorder" },
-- { "─", "FloatBorder" },
-- { "└", "FloatBorder" },
-- { "│", "FloatBorder" },

require("telescope").setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
		},
	},
})

require("telescope").load_extension("fzf")
