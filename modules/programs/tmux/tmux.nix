{
  flake.modules.homeManager.tmux =
    { pkgs, config, ... }:
    let
      tmux-sessionizer = pkgs.writeShellApplication {
        name = "tmux-sessionizer";
        runtimeInputs = with pkgs; [
          fzf
          tmux
        ];
        text = builtins.readFile ./bin/tmux-sessionizer;
      };

      topen = pkgs.writeShellApplication {
        name = "topen";
        runtimeInputs = with pkgs; [
          tmux
        ];
        text = builtins.readFile ./bin/topen;
      };
    in
    {
      home.packages = [
        tmux-sessionizer
        topen
      ];

      programs.tmux = {
        enable = true;

        shell = "${pkgs.zsh}/bin/zsh"; # or "$SHELL" equivalent

        plugins = with pkgs.tmuxPlugins; [
          sensible
          yank
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-strategy-vim 'session'
              set -g @resurrect-strategy-nvim 'session'
              set -g @resurrect-capture-pane-contents 'on'
              set -g @resurrect-save 'S'
            '';
          }
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-boot 'on'
              set -g @continuum-save-interval '10'
            '';
          }
        ];

        extraConfig = ''
          # Options
          set-option -g history-file ~/.tmux_history

          # QoL
          set-option -g mouse on
          set-option -g detach-on-destroy off

          # True colors
          set -g default-terminal "tmux-256color"
          set -sg terminal-overrides ",*:RGB"

          # Disable 'scroll-to-bottom' behavior on mouse highlight in copy-mode
          set -g @yank_action 'copy-pipe' # or 'copy-pipe-and-cancel' for the default

          # Status length
          set -g status-left-length 50
          set -g status-right-length 100

          # Indexing
          set -g base-index 1
          set -g pane-base-index 1
          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          # Prefix
          unbind C-b
          set-option -g prefix C-s
          bind-key C-s send-prefix

          # Popup
          bind-key -n C-f display-popup -w 85% -h 85% -E "tmux-sessionizer"

          # Splits
          bind h split-window -v -c "#{pane_current_path}"
          bind v split-window -h -c "#{pane_current_path}"

          # Navigator logic
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          is_fzf="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"
          is_lzg="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?lazygit$'"

          bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
          bind-key -n C-j if-shell "($is_vim || $is_fzf || $is_lzg)" "send-keys C-j" "select-pane -D"
          bind-key -n C-k if-shell "($is_vim || $is_fzf || $is_lzg)" "send-keys C-k" "select-pane -U"
          bind-key -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

          bind-key -T copy-mode-vi C-h select-pane -L
          bind-key -T copy-mode-vi C-j select-pane -D
          bind-key -T copy-mode-vi C-k select-pane -U
          bind-key -T copy-mode-vi C-l select-pane -R

          bind -r C-h run "tmux select-pane -L"
          bind -r C-j run "tmux select-pane -D"
          bind -r C-k run "tmux select-pane -U"
          bind -r C-l run "tmux select-pane -R"

          unbind r
          bind r source-file ~/.config/tmux/tmux.conf

          # Theme
          source-file ~/.config/tmux/themes/colors/andromeda.conf
          source-file ~/.config/tmux/themes/bubbles.conf
        '';
      };

      home.file = {
        ".config/tmux/themes" = {
          source = ./etc/themes;
          recursive = true;
        };
      };
    };
}
