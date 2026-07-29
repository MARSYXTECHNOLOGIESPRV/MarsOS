#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 06 - Locale Configuration
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
source "$INSTALLER_DIR/lib/locale.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."


    if [[ -z "$LOCALE" ]]; then

        die "No locale selected."

    fi



    log "Configuring locale: $LOCALE"



    locale_set \
        "$LOCALE" \
        || die "Failed configuring locale."



    success \
"Locale configured.

Locale:
$LOCALE"

}


main
