#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 03 - Disk Selection
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

source "$INSTALLER_DIR/lib/ui.sh"
source "$INSTALLER_DIR/lib/util.sh"
source "$INSTALLER_DIR/lib/config.sh"


##################################################
# Disk Detection
##################################################

get_disks() {

    lsblk \
        -dpno NAME,SIZE,TYPE \
        | awk '$3=="disk" {print $1 " " $2}'

}


##################################################
# Main
##################################################

main() {


    local MENU_ITEMS=()


    while read -r DISK SIZE; do

        MENU_ITEMS+=(
            "$DISK"
            "$SIZE"
        )

    done < <(get_disks)



    if [[ "${#MENU_ITEMS[@]}" -eq 0 ]]; then

        die "No disks detected."

    fi



    local SELECTED_DISK


    SELECTED_DISK=$(ui_menu \
        "Disk Selection" \
        "Select the disk where Mars OS will be installed:" \
        "${MENU_ITEMS[@]}"
    )



    if [[ -z "$SELECTED_DISK" ]]; then

        die "No disk selected."

    fi



    if ! ui_yesno \
        "Confirm Disk" \
"Selected disk:

$SELECTED_DISK

WARNING:
All data on this disk may be erased.

Continue?"; then

        die "Disk selection cancelled."

    fi



    config_set TARGET_DISK "$SELECTED_DISK"


    ui_msgbox \
        "Disk Selected" \
"Installation target:

$SELECTED_DISK"


}


main
