#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 04 - Generate fstab
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



##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."



    log "Generating fstab"



    if [[ ! -d /mnt/etc ]]; then

        die "Target filesystem is not mounted."

    fi



    genfstab \
        -U \
        /mnt \
        > /mnt/etc/fstab \
        || die "Failed generating fstab."



    success \
"fstab generated successfully."

}



main
