{
  programs.kitty = {
    enable = true;

    settings = {
      term = "xterm-256color";

      # Fonts
      font_family = "JetBrainsMono Nerd Font Mono";
      bold_font = "JetBrainsMono Nerd Font Mono Bold";
      italic_font = "JetBrainsMono Nerd Font Mono Medium Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Mono Bold Italic";
      font_size = 13.0;
      modify_font = "cell_height 3px";
      disable_ligatures = "never";

      # Transparency & blur
      background_opacity = "0.75";
      background_blur = 32;
      dynamic_background_opacity = true;

      # Remote control
      allow_remote_control = true;

      # Window
      window_border_width = "1.00";
      window_padding_width = "5.00";
      window_margin_width = "5.00";
      hide_window_decorations = "titlebar-only";
      macos_show_window_title_in = "window";

      # Layout
      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;

      # Mouse
      mouse_hide_wait = "1.00";
      copy_on_select = true;
      cursor_shape = "block";
      cursor_blink_interval = "0.50";
      shell_integration = "no-cursor";

      # Bell
      enable_audio_bell = false;
    };

    extraConfig = ''
      include themes/andromeda.conf
    '';
  };

  home.file = {
    ".config/kitty/themes" = {
      source = ./themes;
      recursive = true;
    };
  };
}
