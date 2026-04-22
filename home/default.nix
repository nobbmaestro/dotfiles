username:
{ ... }:
{
  xdg.enable = true;

  imports = [
    ./bin
    ./config/aerospace
    ./config/direnv
    ./config/exa
    ./config/fzf
    ./config/git
    ./config/kitty
    ./config/lazydocker
    ./config/lazygit
    ./config/lazyhis
    ./config/nvim
    ./config/starship
    ./config/tmux
    ./config/yazi
    ./config/zoxide
    ./config/zsh
  ];

  home = {
    username = username;

    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
    };

    stateVersion = "24.11";
  };
}
