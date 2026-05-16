{
  inputs,
  ...
}:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { ... }:
    {
      treefmt = {
        programs.nixfmt.enable = true;
        programs.stylua.enable = true;
        programs.shfmt.enable = true;
      };
    };
}
