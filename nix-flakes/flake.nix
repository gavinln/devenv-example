# vim: sw=2 ts=2 sts=2 et
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  # simple way to specify nix build options
  # {
  #   packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
  #   packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  # };
  # nested way to specify nix build options 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    packages.${system} = {
      default = pkgs.hello;
    };
  };
}
