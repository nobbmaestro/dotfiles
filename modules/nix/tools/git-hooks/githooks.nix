{
  inputs,
  ...
}:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit = {
        settings.hooks = {
          treefmt = {
            enable = true;
            package = config.treefmt.build.wrapper;
          };
        };
      };

      apps.install-hooks = {
        type = "app";
        program = "${pkgs.writeShellScript "install-hooks" config.pre-commit.installationScript}";
      };
    };
}
