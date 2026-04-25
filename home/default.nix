{ ... }:
{
  xdg.enable = true;

  imports = [
    ./scripts
    ./programs/aerospace
    ./programs/direnv
    ./programs/exa
    ./programs/fzf
    ./programs/git
    ./programs/kitty
    ./programs/lazydocker
    ./programs/lazygit
    ./programs/lazyhis
    ./programs/nvim
    ./programs/starship
    ./programs/tmux
    ./programs/yazi
    ./programs/zoxide
    ./programs/zsh
  ];

  home = {
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
    };

    stateVersion = "24.11";
  };
}
