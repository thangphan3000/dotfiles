local modules = require("modules")

local function map(mode, keys, actions, desc)
	desc = desc or ""
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, actions, opts)
end

local M = {}

M.map = map

M.general = function()
	-- insert movement
	map("i", "<c-l>", "<C-o>A")
	map("i", "jk", "<esc>")

	-- Use tab with text block
	map("v", "<Tab>", ">gv")
	map("v", "<S-Tab>", "<gv")

	-- Save only on new changes
	map("i", "ww", "<ESC>:w<CR>")
	map("n", "<C-s>", "<cmd>:w<CR>")

	map("n", "<Esc><Esc>", ":nohlsearch<CR>")
	map("n", "<C-a>", "gg<S-v>G")
	map("n", ";", ":")
	map("n", "dw", 'vb"_d')

	-- Split and navigate to the splitted one
	map("n", "ss", ":split<Return><C-w>w")
	map("n", "sv", ":vsplit<Return><C-w>w")

	-- Switching splits
	map("n", "<C-h>", "<C-w>h")
	map("n", "<C-j>", "<C-w>j")
	map("n", "<C-k>", "<C-w>k")
	map("n", "<C-l>", "<C-w>l")

	map("n", "H", "^")
	map("n", "L", "g_")
	map("v", "H", "^")
	map("v", "L", "g_")

	map("n", "<Tab>", "<cmd>bnext<CR>")
	map("n", "<s-Tab>", "<cmd>bprev<CR>")

	map("n", "<leader>tn", function()
		modules.toggle_numbering()
	end, "Toggle line numbering")

	-- modules.cowboy()
end

M.lsp = function()
	map("n", "gi", "<cmd>Glance implementations<CR>")
	map("n", "gd", "<cmd>Glance definitions<CR>")
	map("n", "gr", "<cmd>Glance references<CR>")
	map("n", "gy", "<cmd>Glance type_definitions<CR>")

	map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
	map("n", "[d", "<cmd>lua vim.dianostics.goto_next()<CR>")
	map("n", "]d", "<cmd>lua vim.dianostics.goto_prev()<CR>")
	map("n", "<space>rn", "<cmd>Lspsaga rename<CR>")
	map("n", "<C-e>", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
end

return M
