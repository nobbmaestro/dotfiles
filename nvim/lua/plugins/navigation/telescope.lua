return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        event = { "VimEnter" },
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope: Search files (git)" })
            vim.keymap.set("n", "<leader>t", builtin.builtin, { desc = "Telescope: Open telescope" })
            vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: Git status" })
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
                },
                pickers = {
                    git_files = {
                        theme = "dropdown",
                        previewer = false,
                    },
                    diagnostics = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = {
                            height = 0.35,
                        },
                    },
                    lsp_references = {
                        theme = "ivy",
                        show_line = false,
                        layout_config = {
                            height = 0.35,
                        },
                    },
                },
                extensions = {
                    -- ...
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
