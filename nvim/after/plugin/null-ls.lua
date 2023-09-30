local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

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
    },
})
require("mason-null-ls").setup({
    ensure_installed = {
        "isort",
        "prettier",
        "pyright",
        "shellcheck",
        "shfmt",
        "stylua",
        "yapf",
    },
    automatic_installation = true,
})
