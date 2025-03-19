-- Specify how the border looks like
local border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- Add border to the diagnostic popup window
vim.diagnostic.config({
	-- virtual_text = {
	-- 	prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
	-- },
	float = { border = border },
})

-- Add the border on hover and on signature help popup window
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local on_attach = function(_, bufnr)
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

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup() -- NOTE: should probably switch over to lazydev.nvim (https://github.com/folke/lazydev.nvim)
require("lspconfig").lua_ls.setup({
	handlers = handlers,
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

require("lspconfig").nixd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "nixd" },
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
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

require("lspconfig").zls.setup({
	handlers = handlers,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
})

require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	-- settings = {
	-- 	["rust-analyzer"] = {
	-- 		diagnostics = {
	-- 			enable = false,
	-- 		},
	-- 	},
	-- },
})

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})

require("lspconfig").svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
})

require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
				unknownProperties = "ignore", -- Ignore unknown CSS properties (useful for Tailwind)
				vendorPrefix = "ignore", -- Don't warn about vendor prefixes
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
				unknownProperties = "ignore",
				vendorPrefix = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
				unknownProperties = "ignore",
				vendorPrefix = "ignore",
			},
		},
	},
})

require("lspconfig").ruff.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
	-- init_options = {
	-- 	settings = {
	-- 		logLevel = "debug",
	-- 	},
	-- },
})

require("lspconfig").pyright.setup({
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
})

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
