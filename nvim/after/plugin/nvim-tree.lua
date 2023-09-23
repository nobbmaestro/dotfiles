vim.g.loaded_netrw = 1
vim.g.loaded_netwnPlugin = 1

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Open project explorer" })
