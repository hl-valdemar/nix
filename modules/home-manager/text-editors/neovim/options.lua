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
vim.cmd("colorscheme kanagawa-paper")

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
