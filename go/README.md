# go environment with flakes

## Setup the nix flake environment

1. Lock the flake

```
nix flake lock
```

2. Install the packages

```
nix develop
```

## Create and run the go program

1. Make a directory for the program

```
mkdir hello
cd hello
```

3. Enable dependency tracking

```
go mod init example/hello
```

4. List code that needs formatting

```
gofmt -l .
```

5. Format the code by updating files

```
gofmt -w .
```

6. Run the code

```
go run .
```

7. Test the code

```
go test
```

8. Run pre-commit checks

```
pre-commit run --all-files
```

## Clean up environment

1. Remove object files

```
go clean
```
