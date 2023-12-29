local status_ok = pcall(require, "neo-tree")
if not status_ok then
    return
end

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Open project explorer" })

require("neo-tree").setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
        },
        name = {
            trailing_slash = true,
            use_git_status_colors = false,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "✚",
                modified = "",
                deleted = "✖",
                renamed = "󰁕",
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
            },
        },
    },
    window = {
        position = "left",
        width = 50,
    },
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = {
                ".DS_Store",
                "thumbs.db",
                "__pycache__",
            },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        hijack_netrw_behavior = "open_default",
    },
})
