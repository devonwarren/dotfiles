#!/usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )")
FILES="${SCRIPT_DIR}/homefiles"

# TODO: create script to recursively copy files and create directories dynamically

# copy files
cp "${FILES}/.zshrc" ~/
cp "${FILES}/.config/starship.toml" ~/.config/starship.toml