{
  programs.lazydocker = {
    enable = false;
  };

  home.file = {
    ".config/lazydocker" = {
      source = ./.;
      recursive = true;
    };
  };
}
