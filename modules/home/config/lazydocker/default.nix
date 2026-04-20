{ ... }:
{
  programs.lazydocker = {
    enable = false;
  };

  home.shellAliases = {
    lzd = "lazydocker";
  };

  home.file = {
    ".config/lazydocker" = {
      source = ./.;
      recursive = true;
    };
  };
}
