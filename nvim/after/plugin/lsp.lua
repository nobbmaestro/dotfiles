local status_ok, lsp_zero = pcall(require, "lsp-zero")
if not status_ok then
    return
end

local function fmt(diagnostic)
  if diagnostic.code then
    return ("[%s] %s"):format(diagnostic.code, diagnostic.message)
  end
  return diagnostic.message
end

-- Fix undefined global `vim`
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lsp_zero.on_attach(function(_, bufnr)
    local nmap = function(mode, keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    -- General LSP keymaps
    nmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    nmap("n", "gr", require("telescope.builtin").lsp_references, "Go to references")
    nmap("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")

    -- Diagnostics keymaps
    nmap("n", "<leader>df", vim.diagnostic.open_float, "Open floating diagnostic message")
    nmap("n", "<leader>dn", vim.diagnostic.goto_next, "Go to next diagnostic message")
    nmap("n", "<leader>dp", vim.diagnostic.goto_prev, "Go to previous diagnostic message")

    -- Refactoring keymaps
    nmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
    nmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename reference")

    -- Help and documentation keymaps
    nmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
    nmap("i", "<C-h>", vim.lsp.buf.signature_help, "Signature documentations")
end)

lsp_zero.set_sign_icons({
    error = "✘",
    hint = "⚑",
    info = "»",
    warn = "▲",
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "always",
        format = fmt,
        severity = {
            -- min = vim.diagnostic.severity.ERROR,
        },
    },
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "lua_ls",
        "pyright",
    },
    handlers = {
        lsp_zero.default_setup,
    },
})
