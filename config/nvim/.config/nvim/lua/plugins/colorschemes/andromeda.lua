return {
    "nobbmaestro/nvim-andromeda",
    lazy = true,
    event = { "VimEnter" },
    priority = 1000,

    branch = "development",
    -- dir = "~/repos/dev-nvim-andromeda",
    dependencies = { "tjdevries/colorbuddy.nvim" },

    config = function()
        require("andromeda").setup({
            preset = "andromeda",
            transparent_bg = true,
            styles = {
                italic = true,
                bold = true,
                underline = true,
                undercurl = true,
            },
        })
    end,
}
