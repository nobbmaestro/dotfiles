{
  inputs,
  ...
}:
let
  username = "norbertbatiuk";
in
{
  flake.modules.homeManager."${username}" =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-desktop
      ];
      home.username = "${username}";
    };
}
