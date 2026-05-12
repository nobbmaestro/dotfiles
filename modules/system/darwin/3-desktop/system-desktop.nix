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
      "logi-options+"
      "monitorcontrol"
      "obsidian"
      "saleae-logic"
      "spotify"
      "stremio"
      "the-unarchiver"
      "whatsapp"
    ];
  };

  flake.modules.homeManager.system-desktop =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-tools

        aerospace
      ];

      home.packages =
        (with inputs.self.packages.${pkgs.system}; [
          kitty
        ])
        ++ (with pkgs; [
          segger-jlink
          wireshark
        ]);
    };
}
