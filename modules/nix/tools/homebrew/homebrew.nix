{
  inputs,
  ...
}:
{
  flake.modules.darwin.homebrew = {
    imports = [
      inputs.nix-homebrew.darwinModules.nix-homebrew
    ];

    nix-homebrew.enable = true;

    homebrew = {
      enable = true;
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
