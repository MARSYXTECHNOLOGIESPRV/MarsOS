#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 13 - Branding
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
source "$INSTALLER_DIR/lib/branding.sh"



##################################################
# Main
##################################################

main() {


    log "Applying OS Release."



    branding_apply \
        || die "OS Release setup failed."



    success \
"\
OS Release applied.
"

}



main
