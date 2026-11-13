#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 09 - System and Desktop Profile
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
# Main
##################################################

main() {


    local BASE_SYSTEM
    ##################################################
    # Firmware Type
    ##################################################

    BASE_SYSTEM=$(ui_menu \
        "System Type" \
        "Select the target firmware:" \
        uefi "Mars OS - Modern UEFI systems" \
        bios "Mars OS Minus - Legacy BIOS systems"
    ) || exit $?



    ##################################################
    # Save Configuration
    ##################################################

    local PROFILE
    PROFILE=$(ui_menu \
        "Desktop Profile" \
        "Select the desktop environment to install:" \
        hyprland "Hyprland" \
        plasma "KDE Plasma"
    ) || exit $?

    config_set FIRMWARE "$BASE_SYSTEM"
    config_set PROFILE "$PROFILE"



    ##################################################
    # Display Selection
    ##################################################

    local BASE_NAME
    local PROFILE_NAME
    case "$BASE_SYSTEM" in

        uefi)
            BASE_NAME="Mars OS (UEFI)"
            ;;

        bios)
            BASE_NAME="Mars OS Minus (Legacy BIOS)"
            ;;

        *)
            BASE_NAME="Unknown"
            ;;

    esac

    case "$PROFILE" in

        hyprland)
            PROFILE_NAME="Hyprland"
            ;;

        plasma)
            PROFILE_NAME="KDE Plasma"
            ;;

    esac



    ##################################################
    # Confirmation
    ##################################################

    ui_msgbox \
        "System Type Selected" \
"Base System:

$BASE_NAME

Desktop:

$PROFILE_NAME"



}


main
