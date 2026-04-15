{
  programs.zsh = {
    enable = true;
  };

  home.file = {
    ".zshenv" = {
      source = ./.zshenv;
    };
    ".config/zsh" = {
      source = ./.;
      recursive = true;
    };
  };
}
