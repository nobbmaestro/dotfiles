username:
{ pkgs, ... }:
{
  home.username = username;
  home.stateVersion = "24.11";

  imports = [
    ./files.nix
    ./nvim.nix
  ];
}
