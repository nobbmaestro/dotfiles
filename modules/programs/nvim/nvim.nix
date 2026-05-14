{
  self,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.neovim = inputs.wrapper-modules.lib.evalPackage [
        self.modules.neovim.main
        { inherit pkgs; }
      ];
    };

  flake.modules.neovim.main =
    {
      config,
      wlib,
      lib,
      pkgs,
      ...
    }:
    let
      nvim-andromeda = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-andromeda";
        src = pkgs.fetchFromGitHub {
          owner = "nobbmaestro";
          repo = "nvim-andromeda";
          rev = "363a0766713c1381b1b6b3a46d22ac6fd5664569";
          hash = "sha256-O3h9+pAOG8G/nhbzDSWFX73JG8cuTmeIfwgvTYGUidM=";
        };
        doCheck = false;
      };
    in
    {
      imports = [ wlib.wrapperModules.neovim ];
      specs.general = with pkgs.vimPlugins; [
        # colorscheme
        nvim-andromeda
        colorbuddy-nvim

        # navigation
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        plenary-nvim
        harpoon
        neo-tree-nvim
        vim-tmux-navigator
        nvim-web-devicons
        nui-nvim

        # utils
        nvim-treesitter.withAllGrammars
      ];
      specs.lazy = {
        lazy = true;
        data = with pkgs.vimPlugins; [
          # plugins which are not loaded until you vim.cmd.packadd them ...
        ];
      };
      info = {
        values = "for lua";
        which = "will be placed in the generated info plugin for access";
      };
      extraPackages = with pkgs; [
        # bash
        bash-language-server
        shellcheck
        shfmt

        # clang
        clang-tools

        # golang
        gopls

        # nix
        nil
        nixfmt

        # python
        pyright
        ruff

        # lua
        lua-language-server
        stylua

        # javascript
        prettier

        # telescope
        ripgrep
      ];
      settings.config_directory = ./src;
    };
}
