-- Comment
require("Comment").setup({
    ---Add a space b/w comment and the line
    padding = false,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    -- ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = "<leader>c",
        ---Block-comment toggle keymap
        block = "<leader>b",
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = "<leader>c",
        ---Block-comment keymap
        block = "<leader>b",
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = "<leader>cO",
        ---Add comment on the line below
        below = "<leader>co",
        ---Add comment at the end of line
        eol = "<leader>ca",
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    -- mappings = {
    --     ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    --     basic = true,
    --     ---Extra mapping; `gco`, `gcO`, `gcA`
    --     extra = true,
    -- },
    -- ---Function to call before (un)comment
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    -- ---Function to call after (un)comment
    -- post_hook = nil,
})
