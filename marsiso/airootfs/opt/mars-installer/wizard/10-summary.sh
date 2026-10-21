#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 09 - Installation Summary
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

    config_load || die "Failed to load installer configuration."

    ##################################################
    # Friendly Names
    ##################################################

    case "$FIRMWARE" in
        uefi) FIRMWARE_NAME="Mars OS (UEFI)" ;;
        bios) FIRMWARE_NAME="Mars OS Minus (Legacy BIOS)" ;;
    esac

    case "$PROFILE" in
        hyprland) PROFILE_NAME="Hyprland" ;;
    esac

    case "$GRAPHICS" in
        auto) GRAPHICS_NAME="Automatic Detection" ;;
        amd) GRAPHICS_NAME="AMD Radeon" ;;
        intel) GRAPHICS_NAME="Intel Integrated" ;;
        nvidia) GRAPHICS_NAME="NVIDIA" ;;
        nvidia-legacy) GRAPHICS_NAME="Legacy NVIDIA (Mesa)" ;;
        vm) GRAPHICS_NAME="Virtual Machine" ;;
    esac

    ##################################################
    # Summary
    ##################################################

    ui_yesno \
        "Installation Summary" \
"Please review your installation settings.

Target Disk:
$TARGET_DISK

Hostname:
$HOSTNAME

Username:
$USERNAME

Locale:
$LOCALE

Timezone:
$TIMEZONE

Graphics:
$GRAPHICS_NAME

System:
$FIRMWARE_NAME

Desktop:
$PROFILE_NAME

Bootloader:
$BOOTLOADER

Begin installation?" || exit $?

}

main
