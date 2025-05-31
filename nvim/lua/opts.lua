local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

opt.laststatus = 0
opt.clipboard = "unnamedplus"
opt.shortmess:append("sI")
opt.termguicolors = true
opt.cursorline = false
opt.swapfile = false
opt.undofile = true
opt.cmdheight = 0
opt.shell = "zsh"
opt.wrap = false
opt.scrolloff = 2

-- Performance
opt.history = 100
opt.updatetime = 400
opt.synmaxcol = 240

-- Indenting
opt.tabstop = 2
opt.shiftwidth = 2
opt.ignorecase = true
-- Trick a tab as whitespace
opt.expandtab = true
opt.backspace = { "start", "eol", "indent" }

g.mapleader = " "
g.border_style = "none" ---@type "single"|"double"|"rounded"|"none"

vim.wo.number = true

-- Load Helm Treesitter highlight when enter buffer
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*/templates/*.yaml,*/templates/*.yml,*/charts/*.yaml,*/charts/*.yml",
	callback = function()
		vim.bo.filetype = "helm"
	end,
})

-- Disable autocomment next line
cmd([[autocmd FileType * set formatoptions-=ro]])

-- Display highlight yank action
cmd([[ augroup highlight_yank]])
cmd([[ autocmd!]])
-- cmd([[ autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({higroup = "Substitute", timeout = 250})]])
cmd([[ autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 250})]])
cmd([[ augroup END]])

return opts
