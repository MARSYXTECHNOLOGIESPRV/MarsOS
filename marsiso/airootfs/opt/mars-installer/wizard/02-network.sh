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

Do you want to configure Wi-Fi now?"; then



        if ! network_has_iwctl; then


            die \
"iwctl was not found.

Cannot configure wireless."

        fi



        ui_msgbox \
            "Wi-Fi Setup" \
"Opening iwd wireless configuration.

Use iwctl to connect to your network.

When finished, exit iwctl
to continue."



        network_wifi_setup



        if network_online; then


            config_set NETWORK "wifi"



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



    fi



    ##################################################
    # No Network
    ##################################################

    die \
"Internet connection is required
to continue installation."

}



main
