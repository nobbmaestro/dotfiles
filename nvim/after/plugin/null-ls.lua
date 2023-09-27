local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

require("mason").setup()
require("null-ls").setup({
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,

		-- bash
		null_ls.builtins.formatting.shfmt,

		-- python
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.formatting.isort,
	},
})
require("mason-null-ls").setup({
	ensure_installed = {
		"isort",
		"pyright",
		"shfmt",
		"stylua",
		"yapf",
	},
	automatic_installation = true,
})
