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
		dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
	},

	-- Navigation
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"theprimeagen/harpoon",
	"folke/flash.nvim",
	"christoomey/vim-tmux-navigator",
	"/nvim-tree/nvim-tree.lua",
	{ "goolord/alpha-nvim", event = "VimEnter" },
	{ "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" } },

	-- Git
	"tpope/vim-fugitive",
	"airblade/vim-gitgutter", -- indicates changes to the file
	"f-person/git-blame.nvim", -- display inline git blame

	-- Utilities
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	"mbbill/undotree",
	"terrortylor/nvim-comment",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- LSP packages
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- null-ls
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
