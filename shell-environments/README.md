# Shell environments

## Ad hoc shell environments

[Ad hoc shell][100] environments

[100]: https://nix.dev/tutorials/first-steps/ad-hoc-shell-environments

Create an ad-hoc shell

```sh
nix-shell -p cowsay lolcat
```

Run a program in a shell and exit

```sh
nix-shell -p cowsay --run "cowsay Nix"
```

List current channel

```sh
nixpkgs https://nixos.org/channels/nixpkgs-unstable
```

Open your web brower to [nix-channels][110] to list all available channels.

[110]: https://channels.nixos.org/

## Reproducible interpreted scripts

List repos belonging to NixOS

```sh
gh repo list NixOS -L 100
```

Create a file called `nixpkgs-release.sh` with the following

```sh
#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash cacert curl jq python3Packages.xmljson
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/2a601aafdc5605a5133a2ca506a34a3a73377247.tar.gz

curl https://github.com/NixOS/nixpkgs/releases.atom | xml2json | jq .
```

## Declarative shell environments

Create a `shell.nix` file containing the following

```nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in pkgs.mkShellNoCC {
  packages = with pkgs; [ cowsay lolcat ];

  GREETING = "Hello, Nix!";

  shellHook = ''
    echo $GREETING | cowsay | lolcat
  '';
}
```

To speed up shell environments use the [nix-direnv][200] package with direnv.

[200]: https://github.com/nix-community/nix-direnv
