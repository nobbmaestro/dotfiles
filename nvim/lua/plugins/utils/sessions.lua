return {
    "rmagatti/auto-session",
    -- lazy = true,
    config = function()
        require("auto-session").setup({
            auto_session_suppress_dirs = { "~/", "~/repos", "~/Downloads/", "/" },
        })
    end,
}
