#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Creating summary"
# ------------------------------------------------------------------------------

e_success "$(uname -p) Architecture"
if has_path "dev"; then
  e_success "$HOME/dev"
else
  e_failure "$HOME/dev"
fi
if has_path "sandbox"; then
  e_success "$HOME/sandbox"
else
  e_failure "$HOME/sandbox"
fi

test_command "xcode-select"
test_command "brew"

# ------------------------------------------------------------------------------
e_message "Summary complete"
# ------------------------------------------------------------------------------
