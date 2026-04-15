{ pkgs, ... }:
let
  nvimLangTools = with pkgs; {
    bash = [
      shellcheck
      shfmt
    ];
    c = [
      clang-tools
    ];
    go = [
      gopls
    ];
    nix = [
      nil
      nixfmt
    ];
    py = [
      pyright
      ruff
    ];
    lua = [
      lua-language-server
      stylua
    ];
    js = [
      prettier
    ];
  };
in
{
  programs.neovim = {
    enable = true;
    extraPackages = builtins.concatLists (builtins.attrValues nvimLangTools);
    withPython3 = true;
    withRuby = true;
  };

  home.file = {
    ".config/nvim" = {
      source = ./.;
      recursive = true;
    }; # FIXME: LazyVim breaks due to read-only permissions
  };
}
