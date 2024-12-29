# List available commands
default:
    just --list --unsorted

# Run tests
test:
    zig build test

# Build project
build:
    zig build --summary all

# Run project
run:
    zig build run

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
