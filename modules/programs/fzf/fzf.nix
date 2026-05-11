{
  flake.modules.homeManager.fzf =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
}
