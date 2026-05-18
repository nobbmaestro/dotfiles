{
  flake.modules.darwin.system-desktop = {
    system = {
      defaults = {
        loginwindow.GuestEnabled = false;

        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          AppleShowAllExtensions = true;
          KeyRepeat = 2;
        };

        finder = {
          _FXSortFoldersFirst = true;
          AppleShowAllFiles = true;
          FXPreferredViewStyle = "SCcf";
          ShowPathbar = true;
        };

        WindowManager.EnableStandardClickToShowDesktop = false;
      };
    };
  };
}
