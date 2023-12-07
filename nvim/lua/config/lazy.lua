local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Colorscheme
    {
        "nobbmaestro/nvim-andromeda",
        branch = "development",
        -- dir = "~/repos/dev-nvim-andromeda",
        dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
    },

    -- Navigation
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "theprimeagen/harpoon" },
    { "christoomey/vim-tmux-navigator" },

    -- Git
    { "tpope/vim-fugitive",                  event = { "BufReadPost", "BufNewFile" } },
    { "airblade/vim-gitgutter",              event = { "BufReadPost", "BufNewFile" } }, -- indicates changes to the file
    { "f-person/git-blame.nvim",             event = { "BufReadPost", "BufNewFile" } }, -- display inline git blame

    -- Utilities
    { "nvim-treesitter/nvim-treesitter",     event = { "BufReadPost", "BufNewFile" } },
    { "nvim-treesitter/playground",          event = { "BufReadPost", "BufNewFile" } },
    { "mbbill/undotree",                     event = { "BufReadPost", "BufNewFile" } },
    { "terrortylor/nvim-comment",            event = { "BufReadPost", "BufNewFile" } },
    { "nvim-lualine/lualine.nvim",           event = { "VeryLazy" } },
    { "m4xshen/autoclose.nvim" },

    -- UI Utilities
    { "goolord/alpha-nvim",                  event = { "VimEnter" } },
    { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" }, version = "2.20.8" },
    { "HiPhish/rainbow-delimiters.nvim",     event = { "BufReadPost", "BufNewFile" } },
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
            { "jose-elias-alvarez/null-ls.nvim" },

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
}

local opts = {}

require("lazy").setup(plugins, opts)
