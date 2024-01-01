return {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        require("autoclose").setup()
    end,
}
