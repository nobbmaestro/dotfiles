{
  flake.modules.homeManager.aerospace = {
    programs.aerospace = {
        enable = true;

        launchd.enable = true;

        settings = {
          after-startup-command = [ "workspace home" ];

          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = true;

          accordion-padding = 30;
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";

          key-mapping.preset = "qwerty";

          on-focus-changed = [ "move-mouse window-lazy-center" ];
          on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

          gaps = {
            inner.horizontal = 8;
            inner.vertical = 8;
            outer.left = 8;
            outer.bottom = 8;
            outer.top = 8;
            outer.right = 8;
          };

          mode.main.binding = {
            # See: https://nikitabobko.github.io/AeroSpace/commands#layout
            alt-f = "fullscreen";
            alt-period = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            # See: https://nikitabobko.github.io/AeroSpace/commands#resize
            alt-minus = "resize smart -50";
            alt-equal = "resize smart +50";
            alt-backspace = "balance-sizes";

            # See: https://nikitabobko.github.io/AeroSpace/commands#focus
            alt-ctrl-h = "focus left";
            alt-ctrl-j = "focus down";
            alt-ctrl-k = "focus up";
            alt-ctrl-l = "focus right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
            ctrl-0 = "workspace home";
            ctrl-1 = "workspace term";
            ctrl-2 = "workspace web";
            ctrl-3 = "workspace dev-web";
            ctrl-4 = "workspace chat";
            ctrl-5 = "workspace mail";
            ctrl-6 = "workspace notes";
            ctrl-7 = "workspace other-1";
            ctrl-8 = "workspace other-2";
            ctrl-9 = "workspace other-3";

            ctrl-right = "exec-and-forget ~/.local/bin/cycle-workspaces --next";
            ctrl-left = "exec-and-forget ~/.local/bin/cycle-workspaces --previous";

            # See: https://nikitabobko.github.io/AeroSpace/commands#mode
            ctrl-m = "mode modify";
          };

          mode.modify.binding = {
            esc = [
              "reload-config"
              "mode main"
            ];
            backspace = [
              "close-all-windows-but-current"
              "mode main"
            ];

            l = [
              "workspace-back-and-forth"
              "mode main"
            ];
            r = [
              "flatten-workspace-tree"
              "mode main"
            ];
            f = [
              "layout floating tiling"
              "mode main"
            ];

            # See: https://nikitabobko.github.io/AeroSpace/commands#move
            ctrl-h = "move left";
            ctrl-j = "move down";
            ctrl-k = "move up";
            ctrl-l = "move right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#join
            alt-ctrl-h = [
              "join-with left"
              "mode main"
            ];
            alt-ctrl-k = [
              "join-with up"
              "mode main"
            ];
            alt-ctrl-j = [
              "join-with down"
              "mode main"
            ];
            alt-ctrl-l = [
              "join-with right"
              "mode main"
            ];

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
            "0" = [
              "move-node-to-workspace home"
              "workspace home"
              "mode main"
            ];
            "1" = [
              "move-node-to-workspace term"
              "workspace term"
              "mode main"
            ];
            "2" = [
              "move-node-to-workspace web"
              "workspace web"
              "mode main"
            ];
            "3" = [
              "move-node-to-workspace dev-web"
              "workspace dev-web"
              "mode main"
            ];
            "4" = [
              "move-node-to-workspace chat"
              "workspace chat"
              "mode main"
            ];
            "5" = [
              "move-node-to-workspace mail"
              "workspace mail"
              "mode main"
            ];
            "6" = [
              "move-node-to-workspace notes"
              "workspace notes"
              "mode main"
            ];
            "7" = [
              "move-node-to-workspace other-1"
              "workspace other-1"
              "mode main"
            ];
            "8" = [
              "move-node-to-workspace other-2"
              "workspace other-2"
              "mode main"
            ];
            "9" = [
              "move-node-to-workspace other-3"
              "workspace other-3"
              "mode main"
            ];

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            tab = [
              "move-workspace-to-monitor --wrap-around next"
              "mode main"
            ];
          };

          on-window-detected = [
            {
              "if".app-id = "net.kovidgoyal.kitty";
              run = "move-node-to-workspace term";
            }
            {
              "if".app-id = "com.apple.Safari";
              check-further-callbacks = true;
              run = "move-node-to-workspace web";
            }
            {
              "if".app-id = "com.apple.Safari";
              "if".window-title-regex-substring = "Development";
              check-further-callbacks = true;
              run = "move-node-to-workspace dev-web";
            }
            {
              "if".app-id = "org.mozilla.firefox";
              run = "move-node-to-workspace dev-web";
            }
            {
              "if".app-id = "com.microsoft.teams";
              run = "move-node-to-workspace chat";
            }
            {
              "if".app-id = "com.microsoft.teams2";
              run = "move-node-to-workspace chat";
            }
            {
              "if".app-id = "net.whatsapp.WhatsApp";
              run = "move-node-to-workspace chat";
            }
            {
              "if".app-id = "com.apple.mail";
              run = "move-node-to-workspace mail";
            }
            {
              "if".app-id = "com.microsoft.Outlook";
              run = "move-node-to-workspace mail";
            }
            {
              "if".app-id = "md.obsidian";
              run = "move-node-to-workspace notes";
            }
            {
              "if".app-id = "com.apple.iBooksX";
              run = "move-node-to-workspace other-1";
            }
            {
              "if".app-id = "com.apple.Preview";
              run = "move-node-to-workspace other-1";
            }
          ];
        };
      };
    };
}
