#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 12 - Bootloader Installation
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
source "$INSTALLER_DIR/lib/profiles.sh"
source "$INSTALLER_DIR/lib/bootloader.sh"



##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."



    if [[ -z "$PROFILE" ]]; then

        die "No profile selected."

    fi



    ##################################################
    # Load Profile
    ##################################################

    profile_load \
        "$PROFILE" \
        || die "Failed loading profile."



    if [[ -z "$BOOTLOADER" ]]; then

        die "Profile does not define a bootloader."

    fi



    log "Installing bootloader: $BOOTLOADER"



    ##################################################
    # Install Bootloader
    ##################################################

    bootloader_install \
        "$BOOTLOADER" \
        || die "Bootloader installation failed."



    success \
"Bootloader installed.

Bootloader:
$BOOTLOADER"

}



main
