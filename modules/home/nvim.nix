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
      nodePackages.prettier
    ];
  };
in
{
  programs.neovim = {
    enable = true;
    extraPackages = builtins.concatLists (builtins.attrValues nvimLangTools);
  };
}
