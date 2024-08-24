{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in {
      # used by: nix develop
      devShells = forAllSystems (system:
        let
          pythonEnv = pkgs.${system}.python312.withPackages
            (ps: with ps; [ pip isort black vulture ]);
        in {
          default = pkgs.${system}.mkShellNoCC {
            packages = with pkgs.${system}; [ ruff poetry pythonEnv ];
          };
        });
      # not supported
      # nix build
      # nix run
      # nix flake check
    };
}
