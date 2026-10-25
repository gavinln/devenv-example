# devenv containers

To build containers with devenv follow this [document][100]. The container is
very large, about 1GB in size and contains nix software.

[100]: https://devenv.sh/containers/

## Build a devenv container shell

1. Build a container

```
devenv container build shell
```

2. Run the container

```
devenv container run shell
```

3. Run the container using docker

```
docker run -it shell:latest
```

4. Display info on the Linux version

```
docker run shell:latest uname -a
```

## Clean up

1. Collect unused nix software

```
devenv gc
```

2. Remove stopped containers

```
docker container prune
```
