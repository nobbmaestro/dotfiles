{
  flake.modules.homeManager.lazydocker = {
    programs.lazydocker.enable = true;

    home.shellAliases = {
      lzd = "lazydocker";
    };

    home.file = {
      ".config/lazydocker" = {
        source = ./etc;
        recursive = true;
      };
    };
  };
}
