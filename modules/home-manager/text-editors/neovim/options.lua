-- Set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use the system clipboard
vim.o.clipboard = "unnamedplus"

-- Set line numbers in the gutter
vim.o.number = true
vim.o.relativenumber = true

-- always show the sign column to avoid horizontal jitter
vim.o.signcolumn = "yes"

-- tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Refresh time in millis
vim.o.updatetime = 300

-- enable 24-bit colour
vim.o.termguicolors = true

-- Enable the mouse
vim.o.mouse = "a"

-- Disable swap files!
vim.o.swapfile = false

-- Set the color scheme
vim.cmd("colorscheme everforest")
