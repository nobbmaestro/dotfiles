{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook-pro-m1 = {
    imports = with inputs.self.modules.darwin; [
      system-desktop
    ];
  };

  flake.darwinConfigurations = inputs.self.lib.mkDarwin "aarch64-darwin" "macbook-pro-m1";
}
