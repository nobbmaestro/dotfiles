{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-base =
    {
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.darwin; [
        home-manager
        homebrew
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = 6;

      environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        darwin-option
        darwin-rebuild
        darwin-version
        darwin-uninstaller
      ];
    };

  flake.modules.homeManager.system-base =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      xdg.enable = true;

      home.homeDirectory =
        if pkgs.stdenv.isDarwin then
          (lib.mkForce "/Users/${config.home.username}")
        else
          "/home/${config.home.username}";

      home.stateVersion = "23.05";
    };
}
