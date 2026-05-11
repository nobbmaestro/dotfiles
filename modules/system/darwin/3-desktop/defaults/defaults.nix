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

          dock = {
            autohide = true;
            magnification = true;
            mru-spaces = false;
            show-recents = false;
            largesize = 70;
            tilesize = 41;
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
