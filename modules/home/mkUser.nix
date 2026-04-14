{ sharedUserDefaults }:

username:
{ pkgs, ... }:
{
  home.username = username;
  home.stateVersion = "24.11";

  targets.darwin.defaults = sharedUserDefaults;

  imports = [
    ./files.nix
    ./nvim.nix
  ];
}
