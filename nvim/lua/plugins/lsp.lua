return function()
	local nvim_lsp = require("lspconfig")

	require("mappings").lsp()

	local border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	}

	local on_attach = function(client, bufnr) end

	-- Enable (broadcasting) snippet capability for completion
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	nvim_lsp.cssls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "css", "scss" },
	})

	nvim_lsp.jdtls.setup({ on_attach = on_attach, capabilities = capabilities })

	nvim_lsp.lua_ls.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
					disable = { "trailing-space" },
				},

				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	})

	nvim_lsp.html.setup({
		on_attach = on_attach,
		filetypes = { "html", "jsp", "ejs", "eruby" },
		capabilities = capabilities,
	})

	nvim_lsp.tailwindcss.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	nvim_lsp.pyright.setup({
		handlers = handlers,
		on_attach = on_attach,
		capability = capabilities,
	})

	nvim_lsp.bashls.setup({ handlers = handlers, on_attach = on_attach })

	-- Golang
	nvim_lsp.gopls.setup({
		on_attach = on_attach,
		handlers = handlers,
		cmd = { "gopls", "serve" },
		settings = { analyses = { unusedparams = true }, staticcheck = true },
	})

	nvim_lsp.terraformls.setup({ on_attach = on_attach })

	-- Dockerfile
	nvim_lsp.dockerls.setup({ on_attach = on_attach })

	nvim_lsp.docker_compose_language_service.setup({ on_attach = on_attach })

	nvim_lsp.eslint.setup({
		on_attach = function(_, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	nvim_lsp.vtsls.setup({ handlers = handlers, on_attach = on_attach })

	local lspIcons = require("utils.icons").lsp
	vim.diagnostic.config({
		virtual_text = {
			virt_text_pos = "eol",
			prefix = "",
			format = function(diagnostic)
				local icons = {
					[vim.diagnostic.severity.ERROR] = lspIcons.error,
					[vim.diagnostic.severity.WARN] = lspIcons.warn,
					[vim.diagnostic.severity.INFO] = lspIcons.info,
					[vim.diagnostic.severity.HINT] = lspIcons.hint,
				}
				return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
			end,
		},
		signs = { text = { ERROR = "", WARN = "", INFO = "", HINT = "" } },
	})
end
