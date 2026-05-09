{
  inputs,
  ...
}:
let
  username = "work";
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
        uid = 502;
      };

      user = {
        work = {
          name = "Norbert Batiuk";
          email = "norbert.batiuk@stagesmarts.com";
        };
      };

      programs.zsh.enable = true;
    };
}
