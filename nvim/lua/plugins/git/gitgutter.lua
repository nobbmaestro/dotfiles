return {
    "airblade/vim-gitgutter",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        vim.keymap.set("n", "gn", "<cmd>GitGutterNextHunk<CR>", { desc = "GitGutter: Go to next hunk" })
        vim.keymap.set("n", "gp", "<cmd>GitGutterPrevHunk<CR>", { desc = "GitGutter: Go to prev hunk" })
    end,
}
