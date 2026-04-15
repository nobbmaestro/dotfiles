{
  programs.lazygit = {
    enable = true;
  };

  home.file = {
    ".config/lazygit" = {
      source = ./.;
      recursive = true;
    };
  };
}
