return function()
	-- Require: npm install -g prettier
	local formatter = require("formatter")
	local util = require("formatter.util")

	local function prettier()
		return {
			exe = "prettier",
			args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
			stdin = true,
		}
	end

	vim.api.nvim_exec(
		[[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.html,*.mjs,*.ts,*.tsx,*.jsx,*.js,*.lua,*.md,*.mdx,*.yml,*.json,*.svelte,*.sol,*.go,*.css,*.yaml,*.rb FormatWrite
        augroup END
    ]],
		true
	)

	formatter.setup({
		logging = false,
		filetype = {
			javascriptreact = { prettier },
			typescriptreact = { prettier },
			typescript = { prettier },
			javascript = { prettier },
			html = { prettier },
			svelte = { prettier },
			css = { prettier },
			scss = { prettier },
			vue = { prettier },
			json = { prettier },
			yaml = { prettier },
			terraform = {},
			markdown = { prettier },
			sh = { prettier },
			go = {
				function()
					return { exe = "gofmt", stdin = true }
				end,
			},
			ruby = {
				function()
					return {
						exe = "rubocop",
						args = {
							"--fix-layout",
							"--stdin",
							util.escape_path(util.get_current_buffer_file_name()),
							"--format",
							"files",
							"--stderr",
						},
						stdin = true,
					}
				end,
			},
			lua = {
				-- luafmt
				function()
					return { exe = "lua-format", stdin = true }
				end,
			},
		},
	})
end
