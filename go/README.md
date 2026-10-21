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

4. Format the code

```
gofmt -w .
```

5. Check for static issues

```
go vet
```

6. Build the code

```
go build
```

7. Run the code

```
go run .
```

8. Test the code

```
go test
```

9. Run pre-commit checks

```
pre-commit run --all-files
```

## Clean up environment

1. Remove object files

```
go clean
```
