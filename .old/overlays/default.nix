{ inputs }:
[
  (import ./claude-code.nix { inherit inputs; })
  (import ./lazyhis.nix { inherit inputs; })
]
