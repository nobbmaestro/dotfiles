{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.experimental-features = "nix-command flakes";

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

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

    stateVersion = 6;
  };
}
