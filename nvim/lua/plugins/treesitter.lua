return function()
	require("nvim-treesitter.install").prefer_git = true

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"javascript",
			"typescript",
			"json",
			"markdown_inline",
			"graphql",
			"tsx",
			"go",
			"hcl",
			"html",
			"jsdoc",
			"rust",
			"css",
			"bash",
			"lua",
			"scss",
			"vim",
		},
		-- autotag = { enable = true },
		indent = { enable = true },
		highlight = { enable = true, use_languagetree = true },
		context_commentstring = { enable = true },
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
		},
	})
end
