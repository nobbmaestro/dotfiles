{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-shell = {
    imports = with inputs.self.modules.darwin; [
      system-base
    ];
  };

  flake.modules.homeManager.system-shell = {
    imports = with inputs.self.modules.homeManager; [
      system-base
    ];
  };
}

