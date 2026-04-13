{
  homebrew = {
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "mole"
      "nobbmaestro/tap/lazyhis"
    ];
    casks = [
      "aldente"
      "alfred"
      "dictionaries"
      # "logi-options+"
      "monitorcontrol"
      "obsidian"
      "saleae-logic"
      "segger-jlink"
      "spotify"
      "stremio"
      "the-unarchiver"
      "wireshark-app"
    ];
  };
}
