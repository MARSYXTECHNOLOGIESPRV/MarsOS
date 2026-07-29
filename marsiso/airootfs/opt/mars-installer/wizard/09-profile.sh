#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 09 - Profile Selection
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
    local PROFILE



    ##################################################
    # Base System
    ##################################################

    BASE_SYSTEM=$(ui_menu \
        "Base System Type" \
        "Select the target firmware:" \
        uefi "Mars OS - Modern UEFI systems" \
        bios "Mars OS Minus - Legacy BIOS systems"
    )


    [[ $? -eq 0 ]] || die "Installation cancelled."



    ##################################################
    # System Profile
    ##################################################

    PROFILE=$(ui_menu \
        "System Profile" \
        "Select the edition of Mars OS to install:" \
        standard "Mars OS Standard (Hyprland)" \
        kde "Mars OS KDE (Plasma)" \
        leite "Mars OS Leite (LXQt)"
    )


    [[ $? -eq 0 ]] || die "Installation cancelled."



    ##################################################
    # Save Configuration
    ##################################################

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

        standard)
            PROFILE_NAME="Mars OS Standard (Hyprland)"
            ;;

        kde)
            PROFILE_NAME="Mars OS KDE (Plasma)"
            ;;

        leite)
            PROFILE_NAME="Mars OS Leite (LXQt)"
            ;;

        *)
            PROFILE_NAME="Unknown"
            ;;

    esac



    ##################################################
    # Summary
    ##################################################

    ui_msgbox \
        "Profile Selected" \
"Base System:

$BASE_NAME

Edition:

$PROFILE_NAME"



}


main
