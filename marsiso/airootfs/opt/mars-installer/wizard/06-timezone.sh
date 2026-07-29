#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 06 - Timezone
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
# Timezone Helpers
##################################################

get_regions() {

    find /usr/share/zoneinfo \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" \
        | grep -vE '^(posix|right|SystemV)$' \
        | sort

}


get_zones() {

    local REGION="$1"

    find "/usr/share/zoneinfo/$REGION" \
        -type f \
        -printf "%P\n" \
        | grep -vE '^(posix|right)' \
        | sort

}


##################################################
# Main
##################################################

main() {


    local REGION
    local CITY
    local TIMEZONE


    ##################################################
    # Locale
    ##################################################

    config_set LOCALE "en_US.UTF-8"



    ##################################################
    # Select Region
    ##################################################

    REGION=$(mktemp)


    get_regions > "$REGION"


    local SELECTED_REGION

    SELECTED_REGION=$(ui_menu_from_file \
        "Timezone Region" \
        "Select your timezone region:" \
        "$REGION"
    )


    rm -f "$REGION"


    if [[ -z "$SELECTED_REGION" ]]; then

        die "No timezone region selected."

    fi



    ##################################################
    # Select City
    ##################################################

    CITY=$(mktemp)


    get_zones "$SELECTED_REGION" > "$CITY"


    local SELECTED_CITY

    SELECTED_CITY=$(ui_menu_from_file \
        "Timezone Location" \
        "Select your timezone location:" \
        "$CITY"
    )


    rm -f "$CITY"



    if [[ -z "$SELECTED_CITY" ]]; then

        die "No timezone location selected."

    fi



    ##################################################
    # Save
    ##################################################

    TIMEZONE="$SELECTED_REGION/$SELECTED_CITY"


    config_set TIMEZONE "$TIMEZONE"



    ui_msgbox \
        "Timezone Saved" \
"Locale:

en_US.UTF-8

Timezone:

$TIMEZONE"


}


main
