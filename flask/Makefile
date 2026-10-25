SCRIPT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SHELL = /bin/bash

# highlight the Makefile targets
# @grep -E '^[a-zA-Z0-9_\-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: help
.DEFAULT_GOAL=help
help:  ## help for this Makefile
	@grep -E '^[a-zA-Z0-9_\-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: fix
fix:  ## run isort and ruff on python code
	ruff check --fix imgapp

.PHONY: env-up
env-up:
	uvx poetry install

.PHONY: env-rm
env-rm:
	uvx poetry env remove $$(uvx poetry env info -e)

.PHONY: imgapp
imgapp: env-up  ## run Flask application
	echo open 127.0.0.1:5000 and 127.0.0.1:5000/image
	echo "Passing $@ to the Python program"
	uvx poetry run python -c "from $@ import main; main()"

.PHONY: build
build: env-up  ## build Flask application
	uvx poetry build

.PHONY: clean
clean: env-rm  ## remove temporary files
	rm -f poetry.lock
	rm -f uv.lock
	rm -rf dist/
	find . -name '.pytest_cache' -type d -exec rm -rf '{}' +
	find . -name '__pycache__' -type d -exec rm -rf '{}' +
	find . -name '.ruff_cache' -type d -exec rm -rf '{}' +
