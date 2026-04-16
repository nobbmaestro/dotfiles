username:
{ ... }:
{
  home.username = username;
  home.stateVersion = "24.11";
  xdg.enable = true;

  imports = [
    ./bin
    ./config/aerospace
    ./config/direnv
    ./config/git
    ./config/kitty
    ./config/lazydocker
    ./config/lazygit
    ./config/lazyhis
    ./config/nvim
    ./config/starship
    ./config/tmux
    ./config/yazi
    ./config/zsh
  ];

}
