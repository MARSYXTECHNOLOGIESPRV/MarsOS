#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Branding Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Apply Branding
##################################################

branding_apply() {


    log "Writing os-release"



    cat > /mnt/etc/os-release <<EOF
NAME="Mars OS"
PRETTY_NAME="Mars OS"
ID=marsos
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="35"
HOME_URL="https://marsos.example"
DOCUMENTATION_URL="https://marsos.example/docs"
SUPPORT_URL="https://marsos.example/support"
BUG_REPORT_URL="https://marsos.example/bugs"
EOF



    log "Writing issue banner"



    cat > /mnt/etc/issue <<EOF
Mars OS 1.1
\\l

EOF



    ##################################################
    # Copy Assets
    ##################################################

    if [[ -d "$INSTALLER_DIR/assets" ]]; then


        mkdir -p /mnt/usr/share/marsos



        cp -r \
            "$INSTALLER_DIR/assets/"* \
            /mnt/usr/share/marsos/ \
            2>/dev/null || true


    fi



    return 0

}
