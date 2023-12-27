local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local sql_formatter_config_file = os.getenv("HOME") .. "/.config/sql_formatter/sql_formatter.json"

-- Formatting constants
local tab_width = 4
local line_len = 120

require("mason").setup()
require("null-ls").setup({
    sources = {
        -- bash
        null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "bash" } }),

        -- lua
        null_ls.builtins.formatting.stylua,

        -- html, markdown, js and more
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "css", "html", "json", "yaml", "markdown", "javascript", "typescript" },
            extra_args = { "--tab-width", tab_width },
        }),

        -- python
        null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", line_len } }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.djlint.with({
            extra_args = { "--blank-line-after-tag", "load,extends,include,endblock" },
        }),

        -- sql
        null_ls.builtins.formatting.sql_formatter.with({ extra_args = { "--config", sql_formatter_config_file } }),
    },
})
require("mason-null-ls").setup({
    ensure_installed = {
        "black",
        "djlint",
        "isort",
        "prettier",
        "pyright",
        "shellcheck",
        "shfmt",
        "sql-formatter",
        "stylua",
    },
    automatic_installation = true,
})
