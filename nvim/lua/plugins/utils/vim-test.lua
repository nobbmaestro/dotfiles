return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux",
    },

    vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { desc = "Vimtest: Run nearest test" }),
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Vimtest: Run test file" }),
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Vimtest: Run last test" }),
    vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Vimtest: Visit last test" }),
    vim.keymap.set("n", "<leader>tq", ":VimuxCloseRunner<CR>", { silent = true }),

    vim.cmd([[
        let g:VimuxHeight = '25'
        let test#strategy = 'vimux'
        let test#python#runner = "pyunit"
        let g:test#python#pyunit#options = "--verbose"
    ]]),
}
