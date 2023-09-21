local builtins = require("null-ls.builtins")

require("null-ls").setup({
	sources = {
		-- lua
		builtins.formatting.stylua,

		-- bash
		builtins.formatting.shfmt,

		-- python
		builtins.formatting.yapf,
		builtins.formatting.isort,
	},
})
