return {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        local plugin = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [""] = plugin.strategy["global"],
                vim = plugin.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterYellow",
                "RainbowDelimiterViolet",
                "RainbowDelimiterBlue",
                "RainbowDelimiterYellow",
                "RainbowDelimiterViolet",
                "RainbowDelimiterBlue",
            },
        }
    end,
}
