#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 10 - System Profile
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
source "$INSTALLER_DIR/lib/profiles.sh"


##################################################
# Main
##################################################

main() {


    config_load || die "Missing installation configuration."



    if [[ -z "$PROFILE" ]]; then

        die "No profile selected."

    fi



    log "Installing profile: $PROFILE"



    profile_install \
        "$PROFILE" \
        || die "Profile installation failed."



    success \
"Profile installation complete.

Profile:
$PROFILE"

}


main
