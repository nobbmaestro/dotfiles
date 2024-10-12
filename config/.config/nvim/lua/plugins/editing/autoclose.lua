return {
    "m4xshen/autoclose.nvim",
    lazy = true,
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        require("autoclose").setup()
    end,
}
