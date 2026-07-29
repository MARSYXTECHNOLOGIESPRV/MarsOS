#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 09 - Graphics Setup
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
source "$INSTALLER_DIR/lib/graphics.sh"
source "$INSTALLER_DIR/lib/graphics-detect.sh"
echo "graphics.sh loaded"

##################################################
# Main
##################################################

main() {


    config_load || die "Missing installation configuration."



    if [[ -z "$GRAPHICS" ]]; then

        die "No graphics option selected."

    fi


    if [[ "$GRAPHICS" == "auto" ]]; then

    GRAPHICS=$(graphics_detect) \
        || die "Graphics detection failed."

    config_set GRAPHICS "$GRAPHICS"

    log "Detected graphics: $GRAPHICS"

    fi



    log "Installing graphics profile: $GRAPHICS"

    log "Refreshing package databases..."

    pacman -Sy --noconfirm \
    >> "$LOG_FILE" 2>&1 \
    || die "Failed to refresh package databases."

    graphics_install \
        "$GRAPHICS" \
        || die "Graphics installation failed."



    success \
"Graphics setup complete.

Profile:
$GRAPHICS"

}


main
