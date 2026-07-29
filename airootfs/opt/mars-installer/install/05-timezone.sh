#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 05 - Timezone Configuration
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
source "$INSTALLER_DIR/lib/timezone.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."


    if [[ -z "$TIMEZONE" ]]; then

        die "No timezone selected."

    fi



    log "Configuring timezone: $TIMEZONE"



    timezone_set \
        "$TIMEZONE" \
        || die "Failed setting timezone."



    success \
"Timezone configured.

Timezone:
$TIMEZONE"

}


main
