-- local status_ok = pcall(require, "vim-arsync")
-- if not status_ok then
--     return
-- end

vim.keymap.set("n", "<leader>ru", "<cmd>ARsyncUp<CR>", { desc = "Vim-arsync: Sync files up to the remote" })
