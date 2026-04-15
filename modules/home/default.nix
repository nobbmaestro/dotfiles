username:
{ ... }:
{
  home.username = username;
  home.stateVersion = "24.11";

  imports = [
    ./config/git
    ./config/nvim
  ];

  home.file = {
    ".config/aerospace" = {
      source = ./config/aerospace;
      recursive = true;
    };

    ".config/direnv" = {
      source = ./config/direnv;
      recursive = true;
    };

    ".config/lazygit" = {
      source = ./config/lazygit;
      recursive = true;
    };

    ".config/lazyhis" = {
      source = ./config/lazyhis;
      recursive = true;
    };

    ".config/kitty" = {
      source = ./config/kitty;
      recursive = true;
    };

    ".config/starship" = {
      source = ./config/starship;
      recursive = true;
    };

    ".config/tmux" = {
      source = ./config/tmux;
      recursive = true;
    };

    ".config/yazi" = {
      source = ./config/yazi;
      recursive = true;
    };

    ".config/zsh" = {
      source = ./config/zsh;
      recursive = true;
    };

    ".zshenv" = {
      source = ./config/zsh/.zshenv;
    };

    ".local/bin" = {
      source = ./bin;
      recursive = true;
    };
  };
}
