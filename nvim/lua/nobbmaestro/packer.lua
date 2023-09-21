local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use({
		"nobbmaestro/nvim-andromeda",
		branch = "development",
		requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
	})

	-- Navigation
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("theprimeagen/harpoon")
	use({
		"christoomey/vim-tmux-navigator",
		lazy = false,
	})

	-- Git
	use("tpope/vim-fugitive")
	use("airblade/vim-gitgutter") -- indicates changes to the file
	use("f-person/git-blame.nvim") -- display inline git blame

	-- Utilities
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("folke/flash.nvim")
	use("mbbill/undotree")
	use("jose-elias-alvarez/null-ls.nvim")
	use("terrortylor/nvim-comment")

	-- LSP packages
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

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
	})

	-- Automatically set up configuration after cloning packer.nvim
	if packer_boostrap then
		require("packer").sync()
	end
end)
