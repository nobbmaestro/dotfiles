require("null-ls").setup({
    sources = {
        -- lua
        require("null-ls").builtins.formatting.stylua,

        -- python
        require("null-ls").builtins.formatting.yapf,
        require("null-ls").builtins.formatting.isort,
    }
})
