vim.keymap.set("n", "gn", "<cmd>Gitsigns next_hunk<CR>", { desc = "GitSigns: Go to next hunk" })
vim.keymap.set("n", "gp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "GitSigns: Go to prev hunk" })
vim.keymap.set("n", "gh", "<cmd>Gitsigns preview_hunk<CR>", { desc = "GitSigns: Hover preview hunk" })

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 250,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = " <author>, <author_time:%R> - <summary>",
})
