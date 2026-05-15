local plugin = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
    condition = function(bufnr)
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        return ok and parser ~= nil
    end,
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
