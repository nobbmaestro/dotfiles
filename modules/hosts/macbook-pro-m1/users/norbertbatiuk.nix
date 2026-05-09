{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook-pro-m1 = {
    imports = with inputs.self.modules.darwin; [
      norbertbatiuk
    ];

    system.primaryUser = "norbertbatiuk";
    nix-homebrew.user = "norbertbatiuk";
  };
}
