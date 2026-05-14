{
  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      config.global.hide_env_diff = true;
    };

    home.file = {
      ".config/direnv" = {
        source = ./etc;
        recursive = true;
      };
    };
  };
}
