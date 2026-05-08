{ inputs, ... }:

final: prev: {
  claude-code = inputs.claude-code.packages.${final.system}.default;
}
