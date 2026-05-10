{
  flake.modules.homeManager.yazi =
    {
      pkgs,
      config,
      ...
    }:
    {
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
