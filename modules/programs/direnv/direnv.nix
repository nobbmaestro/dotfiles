{
  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    home.file = {
      ".config/direnv" = {
        source = ./etc;
        recursive = true;
      };
    };
  };
}
