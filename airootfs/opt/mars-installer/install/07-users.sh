#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 07 - User Configuration
##################################################

set -e


##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="$(dirname "$SCRIPT_DIR")"



##################################################
# Libraries
##################################################

source "$INSTALLER_DIR/lib/util.sh"
source "$INSTALLER_DIR/lib/config.sh"
source "$INSTALLER_DIR/lib/users.sh"



##################################################
# Main
##################################################

main() {


    config_load || die "Missing installation configuration."



    if [[ -z "$USERNAME" ]]; then

        die "No username configured."

    fi



    log "Creating user: $USERNAME"



    users_create \
        "$USERNAME" \
        "$USER_PASSWORD" \
        "$ROOT_PASSWORD" \
        || die "Failed creating user."



    success \
"User configured.

Username:
$USERNAME"

}


main
