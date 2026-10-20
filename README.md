# devenv example

[devenv][100] is a fast, declarative, reproducible, and composable developer
environment built using [Nix][110]. Nix is a purely functional package manager.

[100]: https://github.com/cachix/devenv

[110]: https://github.com/NixOS/nix

A [Nix Flake][120] is a feature in the Nix package manager that provides a
standardized, reproducible way to define, distribute, and use software packages
and configurations. It includes a `flake.nix` file specifying dependencies
(inputs) and outputs, ensuring consistency and facilitating easy sharing and
composability of Nix expressions.

[120]: https://nixos.wiki/wiki/Flakes

For nix examples look at `gavinln/nix-example` repository.

This project demonstrates two ways to manage a development environment.

1. Use devenv with the imgapp Flask app

2. Use Nix flakes with the hello Flask app

## Common commands for devenv

- devenv info - summary of the current environment
- devenv init - initializes setup
- devenv test - builds your developer environment
- devenv shell - activates your developer environment
- devenv search NAME - searches packages
- devenv update - updates & pins inputs from devenv.yaml into devenv.lock
- devenv gc - deletes unused environments to save disk space
- devenv up - starts processes

## Run the imgapp Flask application with devenv

imgapp is a [Flask][200] application

[200]: https://github.com/pallets/flask

1. Start the devenv environment

    ```sh
    devenv shell
    ```

2. Test pre-commit hooks

    ```sh
    pre-commit run
    ```

3. Setup pre-commit hooks

    ```sh
    pre-commit install
    ```

4. Run imgapp

    ```sh
    make imgapp
    ```

5. Open a web browser at `http://127.0.0.1:5000/`

6. View an image at `http://127.0.0.1:5000/image`

7. Build the app

    ```sh
    poetry build
    ```

8. View the build files

    ```sh
    ls dist/
    ```

9. Run app checks

    ```sh
    devenv test
    ```

## Run the hello Flask app with Nix flakes

1. Change to the root directory

```sh
cd python-flake
```

2. Create the lock file

```sh
nix flake lock
```

3. Start a shell with the environment

```sh
nix develop
```

4. Install the poetry dependencies

```sh
poetry install
```

5. Run the Flask app

```sh
poetry run flask --app hello run
```

## Flox

[Flox][300] is a language-agnostic package and environment manager.

[300]: https://flox.dev/docs

## Links

[Reproducible Python environments][1000] with Poetry and Poetry2nix

[1000]: https://www.tweag.io/blog/2020-08-12-poetry2nix/

### Learning nix

[Nix language basics][1010]

[1010]: https://nix.dev/tutorials/nix-language

[Nix flakes][1020]

[1020]: https://nixos.wiki/wiki/Flakes

[Nix series][1030]

[1030]: https://dev.to/arnu515/my-new-nix-series-2cc3

[Nix Flakes Book][1040]

[1040]: https://nixos-and-flakes.thiscute.world/

### nix with AI agents

[LLM Agents in a Nix Sandbox][1100]

[1100]: https://dev.to/andersonjoseph/how-i-run-llm-agents-in-a-secure-nix-sandbox-1899

[Secure AI Agent Setup][1110]

[1110]: https://ranti.dev/blog/securing-ai-agents-with-nix-and-bubblewrap
