#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 01 - Welcome
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


##################################################
# Main
##################################################

main() {

    ui_msgbox \
        "Mars OS Installer v1.1" \
"Welcome to Mars OS.

This installer will guide you through
configuring your installation.

Your choices will be saved and used
to install your system.

Press OK to continue."


    if ! ui_yesno \
        "Warning" \
"All selected disks and partitions may
be formatted during installation.

Make sure you have backups of any
important data.

Continue?"; then

        die "Installation cancelled by user."

    fi

}


main
