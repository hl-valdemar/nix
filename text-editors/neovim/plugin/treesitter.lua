require("nvim-treesitter.configs").setup {
    ensure_installed = {},
    auto_install = false, -- should be disabled as this will cause treesitter to try to write to the nix store (which is readonly)
    highlight = { enable = true },
    indent = { enable = true },
}
