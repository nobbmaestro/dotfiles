{
  flake.modules.homeManager.zoxide =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [ "--cmd cd" ];
      };
    };
}
