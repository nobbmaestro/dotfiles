{ inputs, ... }:

final: prev: {
  lazyhis = inputs.lazyhis.packages.${final.system}.default;
}
