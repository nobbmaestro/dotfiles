local status_ok, plugin = pcall(require, "null-ls")
if not status_ok then
	return
end

local setup = {
	sources = {
		-- lua
		plugin.builtins.formatting.stylua,

		-- bash
		plugin.builtins.formatting.shfmt,

		-- python
		plugin.builtins.formatting.yapf,
		plugin.builtins.formatting.isort,
	},
}

plugin.setup(setup)
