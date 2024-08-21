# devenv example

[devenv][100] is a fast, declarative, reproducible, and composable developer
environment built using [Nix][110]. Nix is a purely functional package manager.

[100]: https://github.com/cachix/devenv

[110]: https://github.com/NixOS/nix

## Setup a new project

- devenv info - summary of the current environment
- devenv init - initializes setup
- devenv test - builds your developer environment
- devenv shell - activates your developer environment
- devenv search <NAME> - searches packages
- devenv update - updates & pins inputs from devenv.yaml into devenv.lock
- devenv gc - deletes unused environments to save disk space
- devenv up - starts processes

## Run a Flask application

imgapp is a [Flask][200] application

[200]: https://github.com/pallets/flask

1. Test pre-commit hooks

```
pre-commit run
```

2. Setup pre-commit hooks

```
pre-commit install
```

3. Run imgapp

```
python -c "import imgapp; imgapp.main()"
```

3. Open a web browser at http://127.0.0.1:5000/

4. View an image at http://127.0.0.1:5000/image

5. Build the app

```
poetry build
```

6. Run app checks

```
devenv test
```

## Links

[Reproducible Python environments][1000] with Poetry and Poetry2nix

https://www.tweag.io/blog/2020-08-12-poetry2nix/