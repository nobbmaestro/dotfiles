{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-desktop = {
    imports = with inputs.self.modules.darwin; [
      system-tools
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-tools

      aerospace
    ];
  };
}
