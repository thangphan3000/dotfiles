return function()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 1,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.zsh,
		float_opts = {
			border = "curved",
			-- width = 120,
			-- height = 20,
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})

	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-J>", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	-- this `gor` cmd is my alias for `go run` command and works even on single files
	vim.cmd([[autocmd FileType go nnoremap <buffer> <leader><leader>g :2TermExec cmd="gor %:p"<CR>]])

	local Terminal = require("toggleterm.terminal").Terminal

	-- local lazygit = Terminal:new({
	--   cmd = "lazygit",
	--   hidden = true,
	--   direction = "float",
	--   close_on_exit = true,
	--   dir = "git_dir",
	--   float_opts = {
	--     border = "curved",
	--     width = 120,
	--     height = 70,
	--   },
	-- })

	local btop = Terminal:new({
		cmd = "btop",
		hidden = true,
		direction = "float",
		close_on_exit = true,
		float_opts = {
			border = "curved",
			width = 120,
			height = 50,
		},
	})

	local k9s = Terminal:new({
		cmd = "k9s",
		hidden = true,
		direction = "float",
		close_on_exit = true,
		float_opts = {
			border = "curved",
			width = 200,
			height = 100,
		},
	})

	-- these get called in keymaps
	-- function _LAZYGIT_TOGGLE()
	--   lazygit:toggle()
	-- end

	function _BTOP_TOGGLE()
		btop:toggle()
	end

	function _K9S_TOGGLE()
		k9s:toggle()
	end
	-- end
end
