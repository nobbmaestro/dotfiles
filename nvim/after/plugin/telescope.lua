local status_ok, plugin = pcall(require, "telescope")
if not status_ok then
    return
end

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope: Search files (git)" })
vim.keymap.set("n", "<leader>t", vim.cmd.Telescope, { desc = "Telescope: Open telescope" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope: Search files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope: Search help" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope: Search by grep" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope: Search for highlighted word" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope: Search diagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope: Search resume" })

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
