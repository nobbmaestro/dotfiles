{
  flake.modules.darwin.system-desktop = {
    system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
