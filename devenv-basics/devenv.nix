# vim: tabstop=2 shiftwidth=2 softtabstop=2 expandtab:
{
  pkgs,
  config,
  lib,
  ...

}: # this is a function with inputs
# pkgs is an input passed as a special argument to the function.

{
  # Our function is returning an attribute set, similar to an object in JSON.
  env.GREET = "hello"; # Attributes can be nested and have similar values as in JSON.

  packages = with pkgs; [
    curl
    jq
  ];

  # silly-example foo=1
  scripts.silly-example.exec = ''
    curl "https://httpbin.org/get?$1" | jq '.args'
  '';

  # script with argument
  scripts.message.exec = ''
    echo "Hello" $@
  '';

  # packages used from script
  # script-packages foo=1
  scripts.script-packages.exec = ''
    ${pkgs.curl}/bin/curl "https://httpbin.org/get?$1" | ${pkgs.jq}/bin/jq '.args'
  '';

  scripts.python-hello = {
    exec = ''
      print("Hello, world!")
    '';
    package = config.languages.python.package;
    description = "hello world in Python";
  };

  scripts.nushell-greet = {
    exec = ''
      def greet [name] {
        ["hello" $name]
      }
      greet "world"
    '';
    package = pkgs.nushell;
    binary = "nu";
    description = "Greet in Nu Shell";
  };

  enterShell = ''
    echo $GREET
    jq --version
  ''; # Values can refer to the inputs
}
