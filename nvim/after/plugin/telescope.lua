local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<C-b>", builtin.git_branches, {})

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
	},
	pickers = {
		git_files = {
			theme = "dropdown",
			previewer = false,
		},
	},
	extensions = {
		-- ...
	},
})
