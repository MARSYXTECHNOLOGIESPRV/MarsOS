#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Bootloader Library
##################################################


##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"



##################################################
# Libraries
##################################################

source "$SCRIPT_DIR/util.sh"
source "$SCRIPT_DIR/grub.sh"
source "$SCRIPT_DIR/systemd-boot.sh"



##################################################
# Install Bootloader
##################################################

bootloader_install() {

    local LOADER="$1"



    if [[ -z "$LOADER" ]]; then

        log "No bootloader specified."

        return 1

    fi



    case "$LOADER" in


        grub)

            log "Installing GRUB"

            grub_install \
                || return 1

            ;;


        systemd-boot)

            log "Installing systemd-boot"

            systemd_boot_install \
                || return 1

            ;;


        *)

            log "Unknown bootloader: $LOADER"

            return 1

            ;;

    esac

}
