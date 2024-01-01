return {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v3.x",
        },

        -- Autocompletion
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },

    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip").filetype_extend("htmldjango", { "html" })

        local cmp = require("cmp")
        local lsp_zero = require("lsp-zero")
        local cmp_action = lsp_zero.cmp_action()
        local cmp_format = lsp_zero.cmp_format()

        cmp.setup({
            formatting = cmp_format,
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer",  keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                -- toggle completion menu
                ["<C-e>"] = cmp_action.toggle_completion(),

                -- tab complete
                ["<Tab>"] = cmp_action.tab_complete(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                -- navigate between snippet placeholder
                ["<C-d>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),

                -- scroll documentation window
                ["<C-f>"] = cmp.mapping.scroll_docs(5),
                ["<C-u>"] = cmp.mapping.scroll_docs(-5),
            }),
        })
    end,
}
