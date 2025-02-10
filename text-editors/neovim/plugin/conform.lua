require("conform").setup({
	formatters_by_ft = {
		nix = { "alejandra" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		svelte = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		go = { "gofumpt", "golines", "goimports-reviser" },
		-- c = { "clang_format" },
		-- cpp = { "clang_format" },
		yaml = { "yamlfmt" },
		toml = { "taplo" },
	},
	-- format_on_save = {
	--     -- These options will be passed to conform.format()
	--     timeout_ms = 500,
	--     lsp_format = "fallback",
	-- },
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
