{
  inputs,
  ...
}:
{
  perSystem =
    { system, ... }:
    {
      packages.lazyhis = inputs.lazyhis.packages.${system}.default;
    };

  flake.modules.darwin.lazyhis =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: _prev: {
          lazyhis = inputs.lazyhis.packages.${final.system}.default;
        })
      ];

      environment.systemPackages = [ pkgs.lazyhis ];
    };

  flake.modules.homeManager.lazyhis = {
    programs.zsh = {
      history = {
        save = 0;
        size = 0;
        ignoreAllDups = true;
        ignoreSpace = true;
      };

      initContent = ''
        if type "lazyhis" >/dev/null 2>&1; then
          if type "zvm_version" >/dev/null 2>&1; then
            zvm_after_init_commands+=('eval "$(lazyhis init zsh)"')
          else
            eval "$(lazyhis init zsh)"
          fi
        fi
      '';
    };

    home.file = {
      ".config/lazyhis" = {
        source = ./etc;
        recursive = true;
      };
    };
  };
}
