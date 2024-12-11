return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        event = { "VimEnter" },
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },

        config = function()
            require("telescope").load_extension("fzf")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope: Search files (git)" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope: Search diagnostics" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope: Search files" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope: Search by grep" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope: Search help" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope: Search resume" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope: Search for highlighted word" })

            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    prompt_prefix = "  ",
                    selection_caret = " ",
                    multi_icon = " ",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    git_files = {
                        theme = "dropdown",
                        previewer = false,
                    },
                    diagnostics = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = {
                            height = 0.25,
                        },
                    },
                    lsp_references = {
                        theme = "ivy",
                        show_line = false,
                        layout_config = {
                            height = 0.25,
                        },
                    },
                },
                extensions = {
                    fzf = {},
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
