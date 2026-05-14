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
    in
    {
      imports = [ wlib.wrapperModules.neovim ];
      specs.general = with pkgs.vimPlugins; [
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
      ];
      settings.config_directory = ./src;
    };
}
