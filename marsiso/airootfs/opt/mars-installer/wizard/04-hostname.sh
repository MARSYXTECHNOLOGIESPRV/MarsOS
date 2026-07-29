#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 04 - Hostname
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
# Validation
##################################################

valid_hostname() {

    local HOST="$1"

    # Length: 1-63 characters
    [[ ${#HOST} -ge 1 && ${#HOST} -le 63 ]] || return 1

    # Only lowercase letters, numbers and hyphens
    [[ "$HOST" =~ ^[a-z0-9-]+$ ]] || return 1

    # Cannot start with a hyphen
    [[ "$HOST" != -* ]] || return 1

    # Cannot end with a hyphen
    [[ "$HOST" != *- ]] || return 1

    return 0

}

##################################################
# Main
##################################################

main() {

    local HOSTNAME

    while true; do

        HOSTNAME=$(ui_input \
            "Hostname" \
            "Enter a hostname for this computer:" \
            "my-awesome-sauce-device")

        if [[ $? -ne 0 ]]; then
            die "Hostname selection cancelled."
        fi

        if valid_hostname "$HOSTNAME"; then
            break
        fi

        ui_msgbox \
            "Invalid Hostname" \
"Hostnames must:

• Be between 1 and 63 characters
• Contain only lowercase letters
  numbers and hyphens
• Not begin with a hyphen
• Not end with a hyphen"

    done

    config_set HOSTNAME "$HOSTNAME"

    ui_msgbox \
        "Hostname Saved" \
"Hostname:

$HOSTNAME"

}

main
