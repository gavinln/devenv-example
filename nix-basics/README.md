# Nix language

This document has tips on learning the [Nix][100] language.

[100]: https://nix.dev/tutorials/nix-language

[Nixpkgs][110] is the largest, most up-to-date software distribution in the
world, and written in the Nix language.

[110]: https://nix.dev/reference/glossary#term-Nixpkgs

## Nix tutorial

Start the Nix repl with the command

```sh
nix repl
```

Evaluate nix files with the command:

```sh
nix-instantiate --eval --strict file.nix
```

### Basics

Example nix expressions

```nix
1 + 2
```

```nix
{ a.b.c = 1; }
```

```nix
let
  x = 1;
  y = 2;
in x + y

```

An attribute set is a collection of names and values

```nix
{
  string = "hello";
  integer = 1;
  float = 3.141;
  bool = true;
  null = null;
  list = [ 1 "two" false ];
  attribute-set = {
    a = "hello";
    b = 2;
    c = 2.718;
    d = false;
  }; # comments are supported
}
```

Recursive attribute sets allow access to attributes within the set

```nix
rec {
  one = 1;
  two = one + 1;
  three = two + 1;
}
```

Let expressions allow assigning names for repeated use.

```nix
let
    a = 1;
in
    a + a
```

Assignments can be in any order in a let expression

```nix
let
  b = a + 1;
  a = 1;
in
  a + b
```

Assignment scope is local

```nix
# does not work
{
  a = let x = 1; in x;
  b = x;
}
```

Attribute access uses a dot

```nix
let
  attrset1 = { x = 1; };
  attrset2 = { a = { b = { c = 1; }; }; };
in
  attrset1.x + attrset2.a.b.c
```

`with` expression allows access to attributes

```nix
let
  a = {
    x = 1;
    y = 2;
    z = 3;
  };
in
  with a; [ x y z ]
```

`inherit` is used to assign the name from an existing scope to a new scope

```nix
let
  x = 1;
  y = 2;
  a = { b = 1; c = 1; };
in
{
  inherit x y;
  inherit (a) b c;
}
```

String interpolation

```nix
let
  name = "Nix";
in
  "hello ${name}"
```

Indented string

```nix
let
  indented_string = ''
    one
    two
  '';
in
  indented_string
```

File system paths

```nix
let
  absolute_path = /nix/store;
  current_dir = ./.;
  parent_dir = ../.;
  lookup_path = <nixpkgs>;
in
  "current_dir = ${parent_dir} parent_dir = ${parent_dir}"
```

```nix
{
  lookup_path = <nixpkgs>;
}
```

### Functions

A function always takes exactly one argument. Argument and function body are
separated by a colon (:).

```nix
let
  f = x: x.a;
  v = { a = 1; };
in
  f v
```

Calling functions

```nix
let
  single_arg_fn = x: x + 1;
  multiple_arg_fn = x: y: x + y;
  attribute_set_arg_fn = {a, b}: a + b;
in
  single_arg_fn 1 + multiple_arg_fn 2 3 + attribute_set_arg_fn { a=1; b=2; }
```

Calling functions with parenthesis

```nix
let
  call_fn_with_parenthesis = (x: x + 1) 1;
  fn = x: x + 1;
in {
  one_element_list = [ (fn 2) ];
  two_elements_list = [ fn 2 ];
}
```

Call curried functions

```nix
let
    multi_argument_fn = x: y: x + y;
in rec {
   single_argument_fn = multi_argument_fn 1;
   value1 = multi_argument_fn 1 2;
   value2 = single_argument_fn 2;
}
```

Default values for attribute set arguments

```nix
let
  f = {a, b ? 0}: a + b;
  g = {a ? 0, b ? 0}: a + b;
in {
  value1 = f { a = 1; };
  value2 = g { a = 3; b = 2; };
  value3 = g { };
}
```

Additional attributes

```nix
let
  f = {a, b, ...}: a + b;
in
  f { a = 1; b = 2; c = 3; }
```

Named attribute arguments

```nix
let
  f = {a, b, ...}@args: a + b + args.c;
in
  f { a = 1; b = 2; c = 3; }
```

## builtins

The builtins library has many functions implemented in C that are part of the
Nix language.

```nix
let
  a = 1;
  b = 2;
in
  builtins.toString a + " " + builtins.toString b
```

## pkgs.lib

The `nixpkgs` repository contains an attribute set called `lib` that contains
useful functions implemented in the Nix language.

```nix
let
  pkgs = import <nixpkgs> {};
in
  pkgs.lib.strings.toUpper "lookup paths considered harmful"
```

## Impurities

## Assigning names and accessing values

Declaring and calling functions

Built-in and library functions

Impurities to obtain build inputs

Derivations that describe build tasks
