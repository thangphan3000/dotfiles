local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = { "LspAttach" },
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "normal",
			},
			completion = {
				menu = {
					border = vim.g.border_style,
					scrolloff = 1,
					scrollbar = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
					window = {
						border = vim.g.border_style,
					},
				},
				ghost_text = { enabled = false },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      require("ibl").setup()
    end
  },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
	},
  -- { 
  --   'xiyaowong/transparent.nvim',
  --   config = function ()
  --     require("transparent").setup({
  --       groups = {
  --         'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
  --         'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
  --         'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
  --         'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
  --         'EndOfBuffer',
  --       },
  --       extra_groups = {
  --         'NeoTreeNormal',
  --         'NeoTreeNormalNC'
  --       },
  --       exclude_groups = {},
  --       on_clear = function() end,
  --     })
  --   end
  -- },
  {
    "beauwilliams/statusline.lua",
    dependencies = {
      "nvim-lua/lsp-status.nvim",
    },
    config = function()
      require("statusline").setup {
        match_colorscheme = true,
        tabline           = false,
        lsp_diagnostics   = true,
        ale_diagnostics   = false,
      }
    end,
  },
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "echasnovski/mini.icons" },
		config = require("plugins.alpha"),
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		enabled = true,
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({ no_ignore = true, hidden = false })
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({ additional_args = { "--hidden" } })
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				";o",
				function()
					local builtin = require("telescope.builtin")
					builtin.oldfiles({ no_ignore = false, hidden = true })
				end,
				desc = "Search recent open files",
			},
			{
				";g",
				function()
					local builtin = require("telescope.builtin")
					builtin.git_status()
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
		},
		config = function(_, _)
			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = "👉 ",
					sorting_strategy = "ascending",
					layout_strategy = "flex",
					entry_prefix = "   ",
					multi_icon = "+ ",
					path_display = { "filename_first" },
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
					file_ignore_patterns = { ".git/", "node_modules" },
					border = true,
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git",
					},
				},
			})
		end,
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = function()
			--- @type Gitsigns.Config
			local C = {
				signs = {
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

					map({ "n", "v" }, "<leader>gg", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
					map({ "n", "v" }, "<leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
					map("n", "<leader>gp", gs.preview_hunk, "Stage Buffer")
					map("n", "<leader>gn", gs.next_hunk, "Stage Buffer")
					map("n", "<leader>gG", gs.stage_buffer, "Stage Buffer")
					map("n", "<leader>gh", gs.preview_hunk, "Preview Hunk")
					map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
					map("n", "<leader>gX", gs.reset_buffer, "Reset Buffer")
					map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
					map("n", "<leader>gb", function()
						gs.blame_line({ full = true })
					end, "Blame Line")
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				end,
			}
			return C
		end,
		keys = {
			-- git hunk navigation - previous / next
			{ "gh", ":Gitsigns next_hunk<CR>", desc = "Goto next git hunk" },
			{ "gH", ":Gitsigns prev_hunk<CR>", desc = "Goto previous git hunk" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},
	{ "alvan/vim-closetag", config = require("plugins.closetag") },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{ "terryma/vim-multiple-cursors" },
	{ "tpope/vim-commentary" },
	{ "LazyVim/LazyVim" },
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>S",
				function()
					require("spectre").toggle()
				end,
				desc = "Replace in files",
			},
			{
				"<leader>Sw",
				function()
					require("spectre").open_visual({ select_word = true })()
				end,
				desc = "Search current word",
			},
			{
				"<leader>Sb",
				function()
					require("spectre").open_file_search({ select_word = true })()
				end,
				desc = "Search current file",
			},
		},
	},
	-- { "psliwka/vim-smoothie" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
			local cmd = vim.cmd
			cmd("syntax on")
			cmd("set termguicolors")
			cmd("colorscheme tokyonight")
			-- cmd("colorscheme tokyonight-day")
    end
  },
	{ "ryanoasis/vim-devicons" },
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					rb = {
						icon = "",
						color = "#ea76cb",
						cterm_color = "65",
						name = "Ruby",
					},
				},
				default = false,
				color_icons = true,
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		config = require("plugins.neotree"),
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			vim.keymap.set("n", "<leader>hl", "<cmd>lua require'hop'.hint_lines()<cr>")
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				default_mappings = true,
				mappings = { i = { j = { k = "<Esc>" } } },
				timeout = 200,
			})
		end,
	},
	{ "folke/which-key.nvim", config = require("plugins.which-key") },
  { 
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    after = "catppuccin",
    config = function()
      require("bufferline").setup {}
    end,
  },
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	dependencies = {
	-- 		{ "folke/trouble.nvim" },
	-- 	},
	-- 	enabled = true,
	-- 	event = "VeryLazy",
	-- 	opts = function()
	-- 		local lspIcons = require("utils.icons").lsp

	-- 		local diagnostics = {
	-- 			"diagnostics",
	-- 			sources = { "nvim_diagnostic" },
	-- 			sections = { "error", "warn", "info", "hint" },
	-- 			symbols = {
	-- 				error = lspIcons.error,
	-- 				hint = lspIcons.hint,
	-- 				info = lspIcons.info,
	-- 				warn = lspIcons.warn,
	-- 			},
	-- 			colored = true,
	-- 			update_in_insert = false,
	-- 			always_visible = false,
	-- 		}

	-- 		local diff = {
	-- 			"diff",
	-- 			symbols = {
	-- 				added = " ",
	-- 				untracked = "󱀶 ",
	-- 				modified = " ",
	-- 				removed = " ",
	-- 			},
	-- 			colored = true,
	-- 			always_visible = false,
	-- 			source = function()
	-- 				local gitsigns = vim.b.gitsigns_status_dict
	-- 				if gitsigns then
	-- 					return {
	-- 						added = gitsigns.added,
	-- 						modified = gitsigns.changed,
	-- 						removed = gitsigns.removed,
	-- 					}
	-- 				end
	-- 			end,
	-- 		}

	-- 		local function show_macro_recording()
	-- 			local recording_register = vim.fn.reg_recording()
	-- 			if recording_register == "" then
	-- 				return ""
	-- 			else
	-- 				return "Recording @" .. recording_register
	-- 			end
	-- 		end

	-- 		return {
	-- 			options = {
	-- 				theme = "auto",
	-- 				globalstatus = true,
	-- 				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
	-- 				section_separators = { left = "", right = "" },
	-- 				component_separators = { left = "", right = "" },
	-- 			},
	-- 			tabline = {
	-- 				lualine_a = {},
	-- 				lualine_b = {},
	-- 				lualine_c = {
	-- 					{
	-- 						"filename",
	-- 						file_status = true,
	-- 						newfile_status = false,
	-- 						-- 0: Just the filename
	-- 						-- 1: Relative path
	-- 						-- 2: Absolute path
	-- 						-- 3: Absolute path, with tilde as the home directory
	-- 						-- 4: Filename and parent dir, with tilde as the home directory
	-- 						path = 1,

	-- 						symbols = {
	-- 							modified = "[+]",
	-- 							readonly = "🔒",
	-- 							unnamed = "[No Name]",
	-- 							newfile = "[New]",
	-- 						},
	-- 					},
	-- 					diff,
	-- 					diagnostics,
	-- 				},
	-- 				lualine_x = {},
	-- 				lualine_y = {},
	-- 				lualine_z = {},
	-- 			},
	-- 			sections = {
	-- 				lualine_a = {},
	-- 				lualine_b = {},
	-- 				lualine_c = { { "macro-recording", fmt = show_macro_recording } },
	-- 				lualine_x = {},
	-- 				lualine_y = {},
	-- 				lualine_z = {},
	-- 			},
	-- 		}
	-- 	end,
	-- },
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
		},
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		opts = {
			file_panel = {
				win_config = {
					position = "bottom",
					height = 20,
				},
			},
			hooks = {
				view_opened = function()
					---@diagnostic disable-next-line: undefined-field
					local stdout = vim.loop.new_tty(1, false)
					if stdout ~= nil then
						stdout:write(
							("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
								"DIFF_VIEW",
								vim.fn.system({ "base64" }, "+4")
							)
						)
						vim.cmd([[redraw]])
					end
				end,
				view_closed = function()
					---@diagnostic disable-next-line: undefined-field
					local stdout = vim.loop.new_tty(1, false)
					if stdout ~= nil then
						stdout:write(
							("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
								"DIFF_VIEW",
								vim.fn.system({ "base64" }, "-1")
							)
						)
						vim.cmd([[redraw]])
					end
				end,
			},
		},
	},
	{ "mhartington/formatter.nvim", config = require("plugins.prettier") },
	{
		"nvimtools/none-ls.nvim",
		dependencies = "davidmh/cspell.nvim",
		config = function()
			local null_ls = require("null-ls")
			local cspell = require("cspell")
			local cspell_config = {
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = vim.diagnostic.severity["HINT"] -- ERROR, WARN, INFO, HINT
				end,
				config = {
					find_json = function(_)
						return vim.fn.expand("~/dotfiles/nvim/cspell.json")
					end,
					on_add_to_json = function(cspell_config_file_path, _, action_name)
						if action_name == "add_to_json" then
							os.execute(
								string.format(
									"cat %s | jq -S '.words |= sort' | tee %s > /dev/null",
									cspell_config_file_path,
									cspell_config_file_path
								)
							)
						end
					end,
				},
			}
			null_ls.setup({
				sources = {
					cspell.diagnostics.with(cspell_config),
					cspell.code_actions.with(cspell_config),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = require("plugins.lsp"),
	},
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		---@class GlanceOpts
		opts = { border = { enable = true, top_char = "―", bottom_char = "―" } },
	},
	{ "yioneko/nvim-vtsls" },
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = { enable = false },
				lightbulb = {
					enable = false,
					sign = true,
					virtual_text = false,
					debounce = 10,
					sign_priority = 20,
				},
			})
		end,
	},
	{ "onsails/lspkind-nvim" },
	{ "williamboman/mason.nvim", lazy = false, config = require("plugins/mason") },
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		event = "VeryLazy",
		---@class NoiceConfig
		opts = {
			---@type NoicePresets
			presets = { inc_rename = true },
			---@type NoiceConfigViews
			views = {
				cmdline_popup = { position = { row = 7, col = "55%" } },
				cmdline_popupmenu = { position = { row = 7, col = "55%" } },
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#2E3440",
			stages = "static",
			timeout = 1500,
		},
	},
})
