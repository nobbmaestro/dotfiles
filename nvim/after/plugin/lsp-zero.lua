local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommended")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"lua_ls",
		"clangd",
	},
	handlers = {
		lsp_zero.defualt_setup,
	},
})

-- Fix Undefined global 'vim'
-- lsp_zero.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- lsp_zero.setup_nvim_cmp({
-- 	mapping = cmp_mappings,
-- })

lsp_zero.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

-- lsp mappings
lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp_zero.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp_zero.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp_zero.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp_zero.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp_zero.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp_zero.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp_zero.buf.signature_help()
	end, opts)
end)

lsp_zero.setup()

-- Show inline diagnostics
vim.diagnostic.config({
	virtual_text = true,
})
