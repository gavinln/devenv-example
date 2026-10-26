# vim: tabstop=2 shiftwidth=2 softtabstop=2 expandtab:
# https://devenv.sh/creating-files/
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.jq ];

  files."config.json".json = {
    database = {
      host = "localhost";
      port = 5432;
    };
    features = [
      "auth"
      "api"
      "ui"
    ];
  };

  files."docker-compose.yml".yaml = {
    version = "3.8";
    services = {
      web = {
        image = "nginx:latest";
        ports = [ "8080:80" ];
      };
    };
  };

  files."config.toml".toml = {
    title = "My App Config";

    server = {
      host = "0.0.0.0";
      port = 8000;
    };
  };

  files."settings.ini".ini = {
    general = {
      debug = "true";
      log_level = "info";
    };
    database = {
      connection_string = "postgres://localhost/mydb";
    };
  };

  files."README-test.txt".text = ''
    This is a development environment.
    Run `devenv shell` to get started.
  '';

  files."setup-test.sh" = {
    text = ''
      #!/bin/bash
      echo "Running setup..."
      npm install
    '';
    executable = true;
  };

  # Seed an editable template once; never overwrites the user's edits.
  files.".env-test.local".copyMode = "seed";
  files.".env-test.local".text = ''
    API_URL=http://localhost:8080
  '';

  # Always overwrite with a fresh writable copy on every shell entry.
  files."config/generated.toml".copyMode = "copy";
  files."config/generated.toml".toml = {
    server.port = 8000;
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # run one task - devenv tasks run myapp:hello
  # run three tasks - devenv tasks run myapp

  # tasks - hello
  tasks."myapp:hello" = {
    exec = ''echo "myapp hello"'';
  };

  # tasks - build
  tasks."myapp:build" = {
    exec = ''echo "myapp build"'';
  };

  # tasks - test
  tasks."myapp:test" = {
    exec = ''echo "myapp test"'';
  };

  # run before enterShell
  tasks = {
    "bash:hello" = {
      exec = "echo 'Hello world before enterShell'";
      before = [ "devenv:enterShell" ];
    };
  };

  # python task
  tasks = {
    "python:hello" = {
      exec = ''
        print("Hello world from Python!")
      '';
      package = config.languages.python.package;
    };
  };

  tasks = {
    "watch:run-if-modified" = {
      exec = "echo run task if json files are modified";
      execIfModified = [
        "*.json" # All JSON files in the current directory
      ];
      # only run in a specific directory
      # cwd = "./devenv-files-tasks";
    };
  };
  tasks = {
    "myapp:mytask" = {
      exec = ''
        echo $DEVENV_TASK_INPUT > $DEVENV_ROOT/input.json
        echo '{ "output": 1 }' > $DEVENV_TASK_OUTPUT_FILE
        echo $DEVENV_TASKS_OUTPUTS > $DEVENV_ROOT/outputs.json
      '';
      input = {
        value = 1;
      };
    };
  };

  # task with 2 inputs: name and value
  # devenv tasks run example:task-with-input
  # devenv tasks run example:task-with-input --input name=Bob --input value=2
  tasks."example:task-with-input" = {
    input = {
      name = "John";
      value = 1;
    };
    exec = ''
      echo "task-with-input $DEVENV_TASK_INPUT"
    '';
  };

  enterShell = ''
    hello         # Run scripts directly
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };
}
