{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/direnv" = {
      source = ./.;
      recursive = true;
    };
  };
}
