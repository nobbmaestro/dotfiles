local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local sql_formatter_config_file = os.getenv("HOME") .. "/.config/sql_formatter/sql_formatter.json"

require("mason").setup()
require("null-ls").setup({
    sources = {
        -- bash
        null_ls.builtins.formatting.shfmt,

        -- lua
        null_ls.builtins.formatting.stylua,

        -- markdown
        null_ls.builtins.formatting.prettier,

        -- python
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.isort,

        -- sql
        -- null_ls.builtins.formatting.sql_formatter,
        null_ls.builtins.formatting.sql_formatter.with({ extra_args = { "--config", sql_formatter_config_file } }),
    },
})
require("mason-null-ls").setup({
    ensure_installed = {
        "isort",
        "prettier",
        "pyright",
        "shellcheck",
        "shfmt",
        "sql-formatter",
        "stylua",
        "yapf",
    },
    automatic_installation = true,
})
