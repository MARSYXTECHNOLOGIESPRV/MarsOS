#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 01 - Partition Disk
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
source "$INSTALLER_DIR/lib/partition.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."


    if [[ -z "$TARGET_DISK" ]]; then
        die "No target disk selected."
    fi


    log "Partitioning $TARGET_DISK"



    if [[ "$FIRMWARE" == "uefi" ]]; then


        partition_uefi \
            "$TARGET_DISK" || die "UEFI partitioning failed."


    elif [[ "$FIRMWARE" == "bios" ]]; then


        partition_bios \
            "$TARGET_DISK" || die "BIOS partitioning failed."


    else

        die "Unknown firmware type: $FIRMWARE"

    fi



    sleep 3



    partition_save_state \
        "$TARGET_DISK" \
        "$FIRMWARE" || die "Failed saving partition information."



    success \
"Partitioning complete.

Disk:
$TARGET_DISK

Firmware:
$FIRMWARE"

}


main
