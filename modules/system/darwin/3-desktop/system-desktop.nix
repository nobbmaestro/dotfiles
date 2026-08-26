{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-desktop = {
    nixpkgs.config.segger-jlink.acceptLicense = true;

    imports = with inputs.self.modules.darwin; [
      system-tools
    ];

    homebrew.casks = [
      "aldente"
      "alfred"
      "dictionaries"
      "figma"
      "logi-options+"
      "monitorcontrol"
      "obsidian"
      "parallels"
      "saleae-logic"
      "spotify"
      "stremio"
      "the-unarchiver"
      "whatsapp"
      "wireshark"
    ];
  };

  flake.modules.homeManager.system-desktop =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-tools

        aerospace
        kitty
      ];

      home.packages = with pkgs; [
        segger-jlink
      ];
    };
}
