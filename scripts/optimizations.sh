#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Running optimizations"
# ------------------------------------------------------------------------------

if has_command "brew"; then
  get_consent "Optimize Homebrew"
  if has_consent; then
    e_pending "Running brew update"
    brew update
    e_pending "Running brew upgrade"
    brew upgrade
    e_pending "Running brew doctor"
    brew doctor
    e_pending "Running brew cleanup"
    brew cleanup
  fi
fi

# ------------------------------------------------------------------------------
e_message "Optimizations complete"
# ------------------------------------------------------------------------------
