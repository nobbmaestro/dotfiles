{
  programs.yazi = {
    enable = true;
  };

  home.file = {
    ".config/yazi" = {
      source = ./.;
      recursive = true;
    };
  };
}
