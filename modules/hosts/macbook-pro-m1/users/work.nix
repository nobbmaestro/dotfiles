{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook-pro-m1 = {
    imports = with inputs.self.modules.darwin; [
      work
    ];
  };
}
