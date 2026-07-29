#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 08 - Hostname Configuration
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
source "$INSTALLER_DIR/lib/hostname.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing installation configuration."



    if [[ -z "$HOSTNAME" ]]; then

        die "No hostname configured."

    fi



    log "Configuring hostname: $HOSTNAME"



    hostname_set \
        "$HOSTNAME" \
        || die "Failed setting hostname."



    success \
"Hostname configured.

Hostname:
$HOSTNAME"

}


main
