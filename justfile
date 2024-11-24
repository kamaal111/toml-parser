# List available commands
default:
    just --list --unsorted

# Build and run project
build-run: build run

# Run tests
test:
    zig build test

# Build project
build:
    zig build --summary all

# Run project
run:
    ./zig-out/bin/toml-parser

# Install modules
install-modules:
    #!/bin/zsh

    . ~/.zshrc || true

# Prepare project to work with
prepare: install-modules

# Bootstrap project
bootstrap: prepare

# Set up dev container. This step runs after building the dev container
post-dev-container-create:
    just .devcontainer/post-create
    just bootstrap
