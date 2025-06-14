local opt = vim.opt
local g = vim.g
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

opt.laststatus = 3
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

-- Load Helm Treesitter highlight
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*/templates/*.yaml,*/templates/*.yml,*/charts/*.yaml,*/charts/*.yml",
	callback = function()
		vim.bo.filetype = "helm"
	end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = "1000" }
  end,
})
-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

return opts
