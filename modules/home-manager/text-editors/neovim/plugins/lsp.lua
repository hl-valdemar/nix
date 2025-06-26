local virtual_lines_active = true

-- Add a border to the diagnostic popup window
vim.diagnostic.config({
    virtual_lines = virtual_lines_active,
})
vim.api.nvim_set_keymap("n", "<leader>tt", ":call v:lua.toggle_diagnostics()<CR>", { noremap = true, silent = true })

local on_attach = function(client, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = bufnr })
    end

    bufmap("<leader>r", vim.lsp.buf.rename)
    bufmap("<leader>a", vim.lsp.buf.code_action)

    bufmap("gd", vim.lsp.buf.definition)
    bufmap("gt", vim.lsp.buf.type_definition)
    bufmap("gD", vim.lsp.buf.declaration)
    bufmap("gI", vim.lsp.buf.implementation)

    bufmap("<leader>d", vim.diagnostic.open_float)

    bufmap("gr", require("telescope.builtin").lsp_references)

    bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
    bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

    bufmap("K", vim.lsp.buf.hover)

    bufmap("<leader>l", function()
        virtual_lines_active = not virtual_lines_active
        if virtual_lines_active then
            vim.diagnostic.config({ virtual_lines = true })
        else
            vim.diagnostic.config({ virtual_lines = false })
        end
    end)

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, {})

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                -- organize imports
                vim.lsp.buf.code_action({
                    context = {
                        only = { "source.organizeImports" },
                    },
                    apply = true,
                })

                -- auto-format
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- require("neodev").setup() -- NOTE: should probably switch over to lazydev.nvim (https://github.com/folke/lazydev.nvim)

vim.lsp.config["lua_ls"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            },
        })
    end,
    settings = {
        Lua = {},
    },
}
vim.lsp.enable("lua_ls")

vim.lsp.config["nixd"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "alejandra" },
            },
        },
    },
    options = {
        nixos = {
            expr = '(builtins.getFlake "/home/hl-valdemar/nixos").nixosConfigurations.default.options',
        },
        --home_manager = {
        --	expr = "(builtins.getFlake \"/PATH/TO/FLAKE\").homeConfigurations.CONFIGNAME.options",
        --},
    },
}
vim.lsp.enable("nixd")

-- require("lspconfig").nixd.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "nixd" },
-- 	settings = {
-- 		nixd = {
-- 			nixpkgs = {
-- 				expr = "import <nixpkgs> { }",
-- 			},
-- 			formatting = {
-- 				command = { "alejandra" },
-- 			},
-- 		},
-- 	},
-- 	options = {
-- 		nixos = {
-- 			expr = '(builtins.getFlake "/home/hl-valdemar/nixos").nixosConfigurations.default.options',
-- 		},
-- 		--home_manager = {
-- 		--	expr = "(builtins.getFlake \"/PATH/TO/FLAKE\").homeConfigurations.CONFIGNAME.options",
-- 		--},
-- 	},
-- })

vim.lsp.config["gopls"] = {
    on_attach = on_attach,
    capabilities = capabilities,
}
vim.lsp.enable("gopls")

-- require("lspconfig").gopls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "gopls" },
-- 	filetypes = { "go", "gomod", "gowork", "gotmpl" },
-- })

vim.lsp.config["zls"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        zls = {
            -- Whether to enable build-on-save diagnostics
            --
            -- Further information about build-on save:
            -- https://zigtools.org/zls/guides/build-on-save/
            -- enable_build_on_save = true,

            -- Neovim already provides basic syntax highlighting
            semantic_tokens = "partial",
        },
    },
}
vim.lsp.enable("zls")

-- require("lspconfig").zls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "zls" },
-- 	filetypes = { "zig", "zir" },
-- })

-- require("lspconfig").rust_analyzer.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	-- settings = {
-- 	-- 	["rust-analyzer"] = {
-- 	-- 		diagnostics = {
-- 	-- 			enable = false,
-- 	-- 		},
-- 	-- 	},
-- 	-- },
-- })

-- require("lspconfig").ts_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "typescript.tsx" },
-- 	cmd = { "typescript-language-server", "--stdio" },
-- })

-- require("lspconfig").svelte.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "svelteserver", "--stdio" },
-- 	filetypes = { "svelte" },
-- })

-- require("lspconfig").cssls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "vscode-css-language-server", "--stdio" },
-- 	filetypes = { "css", "scss", "less" },
-- 	settings = {
-- 		css = {
-- 			validate = true,
-- 			lint = {
-- 				unknownAtRules = "ignore",
-- 				unknownProperties = "ignore", -- Ignore unknown CSS properties (useful for Tailwind)
-- 				vendorPrefix = "ignore", -- Don't warn about vendor prefixes
-- 			},
-- 		},
-- 		scss = {
-- 			validate = true,
-- 			lint = {
-- 				unknownAtRules = "ignore",
-- 				unknownProperties = "ignore",
-- 				vendorPrefix = "ignore",
-- 			},
-- 		},
-- 		less = {
-- 			validate = true,
-- 			lint = {
-- 				unknownAtRules = "ignore",
-- 				unknownProperties = "ignore",
-- 				vendorPrefix = "ignore",
-- 			},
-- 		},
-- 	},
-- })

vim.lsp.config["ruff"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
    -- init_options = {
    -- 	settings = {
    -- 		logLevel = "debug",
    -- 	},
    -- },
}
vim.lsp.enable("ruff")

-- require("lspconfig").ruff.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = { "python" },
-- 	-- init_options = {
-- 	-- 	settings = {
-- 	-- 		logLevel = "debug",
-- 	-- 	},
-- 	-- },
-- })

vim.lsp.config["pyright"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        -- python = {
        -- 	analysis = {
        -- 		-- Ignore all files for analysis to exclusively use Ruff for linting
        -- 		ignore = { "*" },
        -- 	},
        -- },

        -- python = {
        -- 	analysis = {
        -- 		autoSearchPaths = true,
        -- 		diagnosticMode = "openFilesOnly",
        -- 		useLibraryCodeForTypes = true,
        -- 	},
        -- },
    },
}
vim.lsp.enable("pyright")

-- require("lspconfig").pyright.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "pyright-langserver", "--stdio" },
-- 	filetypes = { "python" },
-- 	settings = {
-- 		pyright = {
-- 			-- Using Ruff's import organizer
-- 			disableOrganizeImports = true,
-- 		},
-- 		-- python = {
-- 		-- 	analysis = {
-- 		-- 		-- Ignore all files for analysis to exclusively use Ruff for linting
-- 		-- 		ignore = { "*" },
-- 		-- 	},
-- 		-- },
--
-- 		-- python = {
-- 		-- 	analysis = {
-- 		-- 		autoSearchPaths = true,
-- 		-- 		diagnosticMode = "openFilesOnly",
-- 		-- 		useLibraryCodeForTypes = true,
-- 		-- 	},
-- 		-- },
-- 	},
-- })

vim.lsp.config["clangd"] = {
    on_attach = on_attach,
    capabilities = capabilities,
}
vim.lsp.enable("clangd")
