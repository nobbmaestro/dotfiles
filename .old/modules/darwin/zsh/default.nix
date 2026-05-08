{ pkgs, ... }:
{
  # Fix for zsh compinit "insecure directories" error affecting non-primary users
  system.activationScripts.postActivation.text = ''
    chown root:wheel /nix/var/nix/profiles/default/share/zsh
    chown root:wheel /nix/var/nix/profiles/default/share/zsh/site-functions
    chown root:wheel /nix/var/nix/profiles/default/share/zsh/site-functions/_nix
    chown root:wheel /nix/var/nix/profiles/default/share/zsh/site-functions/run-help-nix
    chmod 755 /nix/var/nix/profiles/default/share/zsh
    chmod 755 /nix/var/nix/profiles/default/share/zsh/site-functions
    chmod 644 /nix/var/nix/profiles/default/share/zsh/site-functions/_nix
    chmod 644 /nix/var/nix/profiles/default/share/zsh/site-functions/run-help-nix
  '';

  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
  };
}
