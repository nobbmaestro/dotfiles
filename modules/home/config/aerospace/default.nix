{
  programs.aerospace = {
    enable = true;
  };

  home.file = {
    ".config/aerospace" = {
      source = ./.;
      recursive = true;
    };
  };
}
