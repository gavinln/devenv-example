{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.curl pkgs.jq pkgs.nushell ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  scripts.silly-example.exec = ''
    ${pkgs.curl}/bin/curl "https://httpbin.org/get?$1" | ${pkgs.jq}/bin/jq '.args'
  '';

  scripts.git-ignored.exec = ''
    git ls-files -i -o --exclude-standard "$@"
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
    hello
    git --version
    silly-example foo=1
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  languages.python.enable = true;
  languages.python.version = "3.12.4";
  languages.python.poetry.enable = true;
  languages.python.poetry.install.enable = false;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  pre-commit.hooks = {

    check-added-large-files.enable = true;
    check-toml.enable = true;
    check-yaml.enable = true;
    end-of-file-fixer.enable = true;
    mixed-line-endings.enable = true;
    trim-trailing-whitespace.enable = true;

    # lint shell scripts
    shellcheck.enable = true;

    # format Python code
    black.enable = true;
    black.settings.flags = "-l 79";

    isort.enable = true;
    isort.settings.flags = "--float-to-top";

    nixfmt.enable = true;

    markdownlint.enable = true;
  };
}
