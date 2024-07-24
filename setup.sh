#!/usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )")
echo $SCRIPT_DIR

# starship config
ln -sf ${SCRIPT_DIR}/.config/starship.toml ~/.config/starship.toml 

# fish config
ln -sf ${SCRIPT_DIR}/.config/fish/config.fish ~/.config/fish/config.fish 

