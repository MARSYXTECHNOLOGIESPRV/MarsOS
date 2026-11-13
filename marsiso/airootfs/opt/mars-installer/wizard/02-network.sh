#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 02 - Network Setup
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
source "$INSTALLER_DIR/lib/network.sh"



##################################################
# Main
##################################################

main() {


    config_init



    ##################################################
    # Check Existing Connection
    ##################################################

    if network_online; then


        config_set NETWORK "connected"



        ui_msgbox \
            "Network" \
            "Internet connection detected.

Continuing installation."

        exit 0


    fi



    ##################################################
    # Ask For Wi-Fi Setup
    ##################################################

    if ui_yesno \
        "Network" \
        "No active internet connection detected.

Do you want to configure a network now?"; then



        if ! network_has_nmtui; then


            die \
        "nmtui was not found.

        Cannot configure the network."

        fi



        ui_msgbox \
            "Network Setup" \
"Opening the NetworkManager text interface.

Use Activate a connection to configure Ethernet or Wi-Fi.

When finished, quit nmtui
to continue."



        network_setup \
            || die "Failed to start NetworkManager or nmtui."



        if network_online; then


            config_set NETWORK "connected"



            ui_msgbox \
                "Network" \
                "Wi-Fi connection successful.

Continuing installation."

            exit 0


        else


            die \
"Wi-Fi configuration completed,
but no internet connection was detected."

        fi



    else
        exit $?
    fi



    ##################################################
    # No Network
    ##################################################

    exit 2

}



main
