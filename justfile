# List available commands
default:
    just --list --unsorted

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
