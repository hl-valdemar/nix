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

-- set the color scheme
-- vim.cmd("colorscheme everforest")
require("vitesse").setup({
	-- Your options
	transparent = true,
	italic_comments = false,
})

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
