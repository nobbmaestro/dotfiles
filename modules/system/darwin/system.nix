{
  inputs,
  ...
}:
{
  flake.modules.darwin.system = {
    imports = with inputs.self.modules.darwin; [
      system-base

      home-manager
    ];
  };

  flake.modules.homeManager.system = {
    imports = with inputs.self.modules.homeManager; [
      system-base

      starship
      zsh
    ];
  };
}
