local status_ok, plugin = pcall(require, "telescope")
if not status_ok then
	return
end

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search files (git)" })
vim.keymap.set("n", "<leader>t", vim.cmd.Telescope, { desc = "Open telescope" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search for highlighted word" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })

local setup = {
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
}

plugin.setup(setup)
