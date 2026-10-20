let pkgs = import <nixpkgs> { };
in pkgs.lib.strings.toUpper "lookup paths considered harmful"
