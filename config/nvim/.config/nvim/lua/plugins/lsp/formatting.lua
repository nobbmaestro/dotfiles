local utils = {
    "clang-format",
    "djlint",
    "goimports",
    "golines",
    "prettier",
    "pyright",
    "ruff",
    "shellcheck",
    "shfmt",
    "sql-formatter",
    "stylua",
}

-- Formatting constants
-- local tab_width = 4
local line_len = 88
local sql_formatter_config_file = os.getenv("HOME") .. "/.config/sql_formatter/sql_formatter.json"

return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "jay-babu/mason-null-ls.nvim" },

    config = function()
        local null_ls = require("null-ls")
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "LSP: Format buffer" })
        null_ls.setup({
            sources = {
                -- c, arduino
                null_ls.builtins.formatting.clang_format.with({ filetypes = { "c", "arduino" } }),

                -- bash
                null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "bash" } }),

                -- lua
                null_ls.builtins.formatting.stylua,

                -- go
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.golines,

                -- html, markdown, js and more
                null_ls.builtins.formatting.prettier.with({
                    filetypes = { "css", "html", "json", "yaml", "markdown", "javascript", "typescript" },
                    -- extra_args = { "--tab-width", tab_width },
                }),

                -- python
                null_ls.builtins.formatting.ruff,
                null_ls.builtins.formatting.djlint.with({
                    extra_args = { "--blank-line-after-tag", "load,extends,include,endblock" },
                }),

                -- sql
                null_ls.builtins.formatting.sql_formatter.with({
                    extra_args = { "--config", sql_formatter_config_file },
                }),
            },
        })
        require("mason-null-ls").setup({
            ensure_installed = utils,
            automatic_installation = true,
        })
    end,
}
