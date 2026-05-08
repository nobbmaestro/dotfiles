{ pkgs, ... }:
let
  nvimLangTools = with pkgs; {
    bash = [
      bash-language-server
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

    viAlias = true;
    vimAlias = true;

    extraPackages = builtins.concatLists (builtins.attrValues nvimLangTools);
    withPython3 = true;
    withRuby = true;
  };

  programs.zsh.initContent = ''
    function nvim() {
      local socket="/tmp/nvim-server-$(tmux display-message -p '#S').sock"
      if [[ ! -S "$socket" ]]; then
        command nvim --listen "$socket" "$@"
      else
        command nvim "$@"
      fi
    }
  '';

  home.file = {
    ".config/nvim" = {
      source = ./src;
      recursive = true;
    }; # FIXME: LazyVim breaks due to read-only permissions
  };
}
