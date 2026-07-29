#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 07 - Graphics
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

    local GPU

    GPU=$(ui_menu \
        "Graphics Driver" \
        "Select the graphics driver to install:" \
        auto    "Automatically detect graphics hardware (Recommended)" \
        amd     "AMD Radeon" \
        intel   "Intel Integrated Graphics" \
        nvidia  "NVIDIA Graphics" \
        vm       "Virtual Machine"
    )

    if [[ $? -ne 0 ]]; then
        die "Graphics selection cancelled."
    fi

    case "$GPU" in
        auto)
            config_set GRAPHICS "auto"
            DISPLAY_NAME="Automatic Detection"
            ;;
        amd)
            config_set GRAPHICS "amd"
            DISPLAY_NAME="AMD Radeon"
            ;;
        intel)
            config_set GRAPHICS "intel"
            DISPLAY_NAME="Intel Integrated Graphics"
            ;;
        nvidia)
            config_set GRAPHICS "nvidia"
            DISPLAY_NAME="NVIDIA Graphics"
            ;;
        vm)
            config_set GRAPHICS "vm"
            DISPLAY_NAME="Virtual Machine"
            ;;
        *)
            die "Invalid graphics selection."
            ;;
    esac

    ui_msgbox \
        "Graphics Selected" \
"Graphics profile:

$DISPLAY_NAME"

}

main
