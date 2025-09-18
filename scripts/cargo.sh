#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Installing Cargo packages"
# ------------------------------------------------------------------------------

cargo install --locked tree-sitter-cli # Tree Sitter CLI for Neovim
