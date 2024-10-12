return {
    "rmagatti/auto-session",

    config = function()
        require("auto-session").setup({
            auto_session_suppress_dirs = { "~/", "~/repos", "~/Downloads/", "/" },
            bypass_session_save_file_types = { 'alpha', 'neo-tree' },
            pre_save_cmds = { "Neotree close" },
        })
    end,
}
