return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        require("ibl").setup({
            indent = { char = "▏" },
            scope = { enabled = false },
        })
    end,
}
