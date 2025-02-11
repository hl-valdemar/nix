-- Stop highlighting
vim.keymap.set("n", "<esc>", vim.cmd.noh)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Toggle file tree/explorer
vim.keymap.set("n", "<leader>v", vim.cmd.NvimTreeToggle)

-- Telescope keymaps
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })

-- Flash movement
local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set({ "o" }, "r", flash.remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })

-- TreeSJ
local treesj = require("treesj")
vim.keymap.set("n", "<leader>s", treesj.split, { desc = "TreeSJ split" })
vim.keymap.set("n", "<leader>j", treesj.join, { desc = "TreeSJ join" })
vim.keymap.set("n", "<leader>m", treesj.toggle, { desc = "TreeSJ toggle split/join" })
vim.keymap.set("n", "<leader>M", function()
	treesj.toggle({ split = { recursive = true } })
end, { desc = "TreeSJ toggle split/join recursively" })

-- -- LSP-lines
-- vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle LSP-lines" })
