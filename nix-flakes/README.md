# nix-flakes

A [Nix Flake][100] is a feature in the Nix package manager that provides a
standardized, reproducible way to define, distribute, and use software packages
and configurations. It includes a `flake.nix` file specifying dependencies
(inputs) and outputs, ensuring consistency and facilitating easy sharing and
composability of Nix expressions.

[100]: https://nixos.wiki/wiki/Flakes

## Introduction to Flakes

[Flakes][200] are similar to other features in the Javascript/Go/Rust/Python
languages. Flakes are made up of two files: a `flake.nix` file and a
`flake.lock` file.

The `flake.nix` file describes dependencies between Nix packages and how to
build projects. It is similar to the files:

package.json  /  go.mod / Cargo.toml / pyproject.toml

The `flake.lock` file locks the dependencies and ensures project
reproduciblity. It is similar to the files:

package-lock.json  /  go.sum / Cargo.lock / poetry.lock

[200]: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/introduction-to-flakes

## New CLI and classic CLI

The `nix-channel` command, in the classic CLI, manages software package
versions through the stable/unstable/test channels. In the `flakes` approach it
has been replaced by the `inputs` section of the `flake.nix` file.

The `nix-env` command, in the classic CLI, installs packages from data sources
added by `nix-channel`. These packages are not recorded by Nix's declarative
configurations, making it challenging to reproduce the configuration on other
machines.

The `nix-build` command builds the Nix packages and places them in
`/nix/store`. In the new CLI, `nix build` replaces it.

The `nix-collect-garbage` cleans up unused store objects. In the new CLI, this
has been partially replaced by `nix store gc --debug`.

## Nix templates

To display all the available Nix templates;

```nix
nix flake show templates
```

Create a `flake.nix` file from the simplest possible template with no output.

```nix
nix flake init -t templates#empty
```

Evaluate the template

```sh
nix eval --file flake.nix
```

Create a trivial example with an output

```sh
nix flake init -t templates#trivial
```

The following `flake.nix` file is created

```nix
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
```

Evaluate the flake.nix file

```sh
nix eval --file flake.nix
```

Add the `flake.nix` file to the git repo to automatically use flake.nix.

```sh
git add flake.nix
```

Evalute the flake without specifying the `flake.nix`

```sh
nix eval
```

This will automatically add the flake.lock file to git with --intent-to-add

```sh
git add --intent-to-add flake.lock
```

Evaluate a specified attribute

```sh
nix eval .#hello
nix eval .#default
```

Build a derivation that creates a `result` link

```sh
nix build
ls -l result*
```

Run a specified attribute

```sh
nix run .#hello
nix run .#default
```

Show the flake as a tree

```sh
nix flake show
```

View info about the flake

```sh
nix flake metadata
```

Delete store paths. This may not free storage space

```sh
nix store gc
```

Free storage

```sh
nix-collect-garbage
```

Use the `full` template to create a flake with standard outputs

```sh
nix flake init -t templates#full
```

## Links

[Nix and direnv][1000]

[1000]: https://www.danielcorin.com/posts/2023/nix-and-direnv/

[Nix and direnv with flakes][1010]

[1010]: https://www.danielcorin.com/til/nix/nix-and-direnv-with-flakes/
