return function()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		ensure_installed = {
			lsp = {
				"eslint-lsp",
				"stylua",
				"luacheck",
				"shellcheck",
				"ruby-lsp",
				"rubocop",
				"css-lsp",
			},
			dap = {
				-- "node-debug2-adapter",
			},
			linter = {
				-- "eslint_d"
			},
			formatter = {
				"prettier",
			},
		},
	})
end
