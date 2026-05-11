{
  flake.modules.homeManager.exa =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs.eza = {
        enable = true;
        icons = "auto";
        extraOptions = [
          "--classify"
          "--group-directories-first"
        ];
        colors = "auto";
      };

      home.shellAliases = {
        la = "ls -al";
        ll = "ls -l";
        ls = "eza --icons --classify --group-directories-first";
        lt = "eza --tree --group-directories-first";
      };

      home.sessionVariables = {
        EZA_COLORS = "di=37;1:fi=37:ex=31:ln=35;1";
      };
    };
}
