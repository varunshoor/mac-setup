#!/bin/bash

source utils.sh

clear

# ------------------------------------------------------------------------------
e_message "Starting mac-setup"
# ------------------------------------------------------------------------------

source defaults.sh
source brew.sh
source appstore.sh
source pip.sh
source dock.sh
source optimizations.sh
source summary.sh

# ------------------------------------------------------------------------------
e_message "mac-setup complete"
# ------------------------------------------------------------------------------
