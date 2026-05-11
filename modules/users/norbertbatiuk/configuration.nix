{
  inputs,
  ...
}:
let
  username = "norbertbatiuk";
in
{
  flake.modules.darwin."${username}" =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.darwin; [ ];

      home-manager.users."${username}" = {
        imports = [ inputs.self.modules.homeManager."${username}" ];
      };

      users.users."${username}" = {
        name = "${username}";
        shell = pkgs.zsh;
        uid = 501;
      };

      programs.zsh.enable = true;
    };

  flake.modules.homeManager."${username}" =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-desktop
      ];
      home.username = "${username}";

      programs.git = {
        enable = true;
        settings.user = {
          name = "Norbert Batiuk";
          email = "norbert@batiuk.se";
        };
      };
    };
}
