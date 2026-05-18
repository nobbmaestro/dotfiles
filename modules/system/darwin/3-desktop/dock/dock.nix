{
  flake.modules.darwin.system-desktop = {
    system.defaults.dock = {
      autohide = true;
      magnification = true;
      mru-spaces = false;
      show-recents = false;
      largesize = 70;
      tilesize = 41;

      persistent-apps = [
        "/System/Applications/Apps.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/App Store.app"
        "/Applications/Safari.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Phone.app"
        "/Applications/Spotify.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Notes.app"
      ];
    };
  };
}
