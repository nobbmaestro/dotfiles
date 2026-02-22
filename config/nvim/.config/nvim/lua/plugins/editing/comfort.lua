return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ lsp_format = "fallback" })
        end, { desc = "Format buffer" })

        require("conform").setup({
            formatters_by_ft = {
                arduino = { "clang-format" },
                c = { "clang-format" },
                go = { "goimports", "golines", "gofmt" },
                lua = { "stylua" },
                python = { "ruff" },
                nix = { "nixfmt" },
                bash = { "shfmt" },
            },
        })
    end,
}
