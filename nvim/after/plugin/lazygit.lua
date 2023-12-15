vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit: Start" })
vim.keymap.set("n", "<leader>gl", vim.cmd.LazyGitFilter, { desc = "LazyGit: Open git log" })
vim.keymap.set("n", "<leader>gbl", vim.cmd.LazyGitFilterCurrentFile, { desc = "LazyGit: Open git buffer log" })

vim.g.lazygit_floating_window_scaling_factor = 1.0
