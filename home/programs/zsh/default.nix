{ config, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = config.xdg.configHome + "/zsh";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    history = {
      save = 0;
      size = 0;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      c = "clear";
      rm = "rm -i";
      fman = "compgen -c | fzf --preview='man {}' | xargs man";
    };

    initContent = ''
      function benchmark_zsh() {
        shell=''${1-$SHELL}
        for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
      }
      function fstr() {
        grep -Rnw "." -e "$1"
      }
      function ssh() {
        if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
          tmux rename-window "$(echo $*)"
          command ssh "$@"
          tmux set-window-option automatic-rename "on" 1>/dev/null
        else
          command ssh "$@"
        fi
      }
      function truecolor-test() {
        awk -v term_cols="''${width:-$(tput cols || echo 80)}" 'BEGIN{
          s="/\\";
          for (colnum = 0; colnum<term_cols; colnum++) {
            r = 255-(colnum*255/term_cols);
            g = (colnum*510/term_cols);
            b = (colnum*255/term_cols);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum%2+1,1);
          }
          printf "\n";
        }'
      }
    '';
  };
}
