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

      user = {
        work = {
          name = "Norbert Batiuk";
          email = "norbert@batiuk.se";
        };
      };

      programs.zsh.enable = true;
    };
}
