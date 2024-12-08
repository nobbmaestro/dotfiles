return {
    "kenn7/vim-arsync",
    enabled = false,
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "prabirshrestha/async.vim" },

    config = function()
        vim.keymap.set("n", "<leader>ru", "<cmd>ARsyncUp<CR>", { desc = "Vim-arsync: Sync files up to the remote" })
    end,
}
