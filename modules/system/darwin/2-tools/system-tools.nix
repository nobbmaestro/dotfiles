{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-tools = {
    imports = with inputs.self.modules.darwin; [
      system-shell
    ];
  };

  flake.modules.homeManager.system-tools = {
    imports = with inputs.self.modules.homeManager; [
      system-shell

      direnv
      fzf
      git
      lazydocker
      lazygit
      nvim
    ];
  };
}
