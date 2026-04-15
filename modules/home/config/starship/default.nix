{
  programs.starship = {
    enable = true;
  };

  home.file = {
    ".config/starship" = {
      source = ./.;
      recursive = true;
    };
  };
}
