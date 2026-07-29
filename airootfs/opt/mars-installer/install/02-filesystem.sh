#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 02 - Filesystem Setup
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
source "$INSTALLER_DIR/lib/filesystem.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."



    if [[ -z "$ROOT_PARTITION" || -z "$SWAP_PARTITION" ]]; then

        die "Missing partition information."

    fi



    log "Starting filesystem setup"



    ##################################################
    # Format Root
    ##################################################

    filesystem_format_root \
        "$ROOT_PARTITION" \
        || die "Failed formatting root partition."



    ##################################################
    # Format Swap
    ##################################################

    filesystem_format_swap \
        "$SWAP_PARTITION" \
        || die "Failed creating swap."



    ##################################################
    # Format EFI
    ##################################################

    if [[ "$FIRMWARE" == "uefi" ]]; then


        filesystem_format_efi \
            "$EFI_PARTITION" \
            || die "Failed formatting EFI partition."


    fi



    ##################################################
    # Mount Root
    ##################################################

    filesystem_mount_root \
        "$ROOT_PARTITION" \
        || die "Failed mounting root filesystem."



    ##################################################
    # Mount EFI
    ##################################################

    if [[ "$FIRMWARE" == "uefi" ]]; then


        filesystem_mount_efi \
            "$EFI_PARTITION" \
            || die "Failed mounting EFI partition."


    fi



    ##################################################
    # Enable Swap
    ##################################################

    filesystem_enable_swap \
        "$SWAP_PARTITION" \
        || die "Failed enabling swap."



    success \
"Filesystem setup complete.

Root:
$ROOT_PARTITION

Swap:
$SWAP_PARTITION

EFI:
${EFI_PARTITION:-Not Used}
"

}


main
