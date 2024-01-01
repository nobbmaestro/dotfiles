return {
    -- Utilities
    { "nvim-treesitter/nvim-treesitter", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-treesitter/playground", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-lualine/lualine.nvim", event = { "VeryLazy" } },
    { "kenn7/vim-arsync", dependencies = { "prabirshrestha/async.vim" } }, -- sync local project to server

    -- UI Utilities
    { "goolord/alpha-nvim", event = { "VimEnter" } },
    { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" }, version = "2.20.8" },
    { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-tree/nvim-web-devicons" },

    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },

            -- LSP server management
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
            { "nvimtools/none-ls.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    { import = "plugins.colorschemes" },
    { import = "plugins.git" },
    { import = "plugins.navigation" },
    { import = "plugins.editing" },
}
