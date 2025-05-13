return function()
	require("lspkind").init({
		-- DEPRECATED (use mode instead): enables text annotations
		--
		-- default: true
		-- with_text = true,

		-- defines how annotations are shown
		-- default: symbol
		-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
		-- mode = 'symbol_text',
		mode = "symbol",

		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = "codicons",

		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
			Text = "   (Text) ",
			Method = "   (Method)",
			Function = "   (Function)",
			Constructor = "   (Constructor)",
			Field = " ﰠ  (Field)",
			Variable = "[] (Variable)",
			Class = "   (Class)",
			Interface = " ﰮ  (Interface)",
			Module = "   (Module)",
			Property = " 襁 (Property)",
			Unit = "   (Unit)",
			Value = "   (Value)",
			Enum = " 練 (Enum)",
			Keyword = "   (Keyword)",
			Snippet = "   (Snippet)",
			Color = "   (Color)",
			File = "   (File)",
			Reference = "   (Reference)",
			Folder = "   (Folder)",
			EnumMember = "   (EnumMember)",
			Constant = " ﲀ  (Constant)",
			Struct = " ﳤ  (Struct)",
			Event = "   (Event)",
			Operator = "   (Operator)",
			TypeParameter = "   (TypeParameter)",
		},
	})
end
