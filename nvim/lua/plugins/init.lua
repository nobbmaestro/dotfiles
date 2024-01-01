return {
    -- Navigation
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "theprimeagen/harpoon" },
    { "christoomey/vim-tmux-navigator" },

    -- Git
    { "kdheepak/lazygit.nvim" },
    { "airblade/vim-gitgutter", event = { "BufReadPost", "BufNewFile" } }, -- indicates changes to the file
    { "f-person/git-blame.nvim", event = { "BufReadPost", "BufNewFile" } }, -- display inline git blame

    -- Utilities
    { "nvim-treesitter/nvim-treesitter", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-treesitter/playground", event = { "BufReadPost", "BufNewFile" } },
    { "mbbill/undotree", event = { "BufReadPost", "BufNewFile" } },
    { "terrortylor/nvim-comment", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-lualine/lualine.nvim", event = { "VeryLazy" } },
    { "kenn7/vim-arsync", dependencies = { "prabirshrestha/async.vim" } }, -- sync local project to server

    -- UI Utilities
    { "goolord/alpha-nvim", event = { "VimEnter" } },
    { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" }, version = "2.20.8" },
    { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },
    { "nvim-tree/nvim-web-devicons" },
    {
        "/nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = "MunifTanjim/nui.nvim",
    },

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
    { import = "plugins.editing" },
}
