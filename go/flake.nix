# vim: sw=2 ts=2 sts=2 et

# Setup a go development shell using flake with lint, pre-commit and tests.
# Do not use flake-utils

# nix flake lock  # create the flake.lock file
# nix develop  # setup the development environment

{
  description = "Go development with pre-commit, lint, tests";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              go
              pre-commit
              yamlfmt
              nixfmt
            ];
          };
        }
      );
    };
}
