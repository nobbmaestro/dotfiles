{
  inputs,
  ...
}:
{
  flake.modules.darwin.system =
    {
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      system.stateVersion = 6;

      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config system;
          };
        })
      ];

      environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        darwin-option
        darwin-rebuild
        darwin-version
        darwin-uninstaller
      ];

    };
}
