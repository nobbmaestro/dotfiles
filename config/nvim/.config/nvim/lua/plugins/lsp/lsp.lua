local servers = {
    "bashls",
    "clangd",
    "gopls",
    "lua_ls",
    "pyright",
}

local function fmt(diagnostic)
    if diagnostic.code then
        return ("[%s] %s"):format(diagnostic.code, diagnostic.message)
    end
    return diagnostic.message
end

return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local lsp_zero = require("lsp-zero")
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "neovim/nvim-lspconfig",
        },

        config = function()
            -- Add border to LspInfo float window
            require("lspconfig.ui.windows").default_options.border = "single"

            local lsp_zero = require("lsp-zero")
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

                -- Diagnostics keymaps
                nmap("n", "<leader>df", vim.diagnostic.open_float, "Open floating diagnostic message")
                nmap("n", "<leader>dn", vim.diagnostic.goto_next, "Go to next diagnostic message")
                nmap("n", "<leader>dp", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
                nmap("n", "<leader>dd", vim.cmd.ToggleDiagnostics, "Toggle virtual diagnostic messages")

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
        end,
    },
}
