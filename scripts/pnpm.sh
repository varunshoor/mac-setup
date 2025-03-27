#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Installing NPM packages"
# ------------------------------------------------------------------------------

pnpm install -g @anthropic-ai/claude-code
