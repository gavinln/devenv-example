{
  pkgs,
  ...

}: # this is a function with inputs
# pkgs is an input passed as a special argument to the function.

{
  # Our function is returning an attribute set, similar to an object in JSON.
  env.GREET = "hello"; # Attributes can be nested and have similar values as in JSON.

  packages = [ pkgs.jq ];

  enterShell = ''
    echo $GREET
    jq --version
  ''; # Values can refer to the inputs
}
