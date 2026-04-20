username:
{ ... }:
{
  home.username = username;
  home.stateVersion = "24.11";
  xdg.enable = true;

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
  };

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

}
