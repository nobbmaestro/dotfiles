{ ... }:
{
  programs.zsh.initContent = ''
    if type "lazyhis" >/dev/null 2>&1; then
      if type "zvm_version" >/dev/null 2>&1; then
        zvm_after_init_commands+=('eval "$(lazyhis init zsh)"')
      else
        eval "$(lazyhis init zsh)"
      fi
    fi
  '';

  home.file = {
    ".config/lazyhis" = {
      source = ./.;
      recursive = true;
    };
  };
}
