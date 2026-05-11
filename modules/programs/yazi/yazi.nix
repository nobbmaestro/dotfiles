{
  flake.modules.homeManager.yazi = {
    programs.yazi = {
      enable = true;

      shellWrapperName = "y";
    };

    home.file = {
      ".config/yazi" = {
        source = ./etc;
        recursive = true;
      };
    };
  };
}
