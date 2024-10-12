return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    version = "2.20.8",

    config = function()
        require("indent_blankline").setup({
            char = "▏",
            context_char = "▏",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_current_context = true,
        })
    end,
}
