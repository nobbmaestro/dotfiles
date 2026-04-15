{
  programs.direnv = {
    enable = true;
  };

  home.file = {
    ".config/direnv" = {
      source = ./.;
      recursive = true;
    };
  };
}
