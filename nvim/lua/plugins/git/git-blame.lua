return {
    "f-person/git-blame.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        vim.g.gitblame_date_format = "%r"
        vim.g.gitblame_delay = 250 -- "0.25 second"
        vim.g.gitblame_highlight_group = "GitBlameMsg"
        vim.g.gitblame_message_template = "      <author>, <date> • <summary>"
        vim.g.gitblame_message_when_not_committed = "      Uncommited changes"
    end,
}
