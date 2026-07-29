#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Bundle Library
##################################################


##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INSTALLER_DIR="$(dirname "$SCRIPT_DIR")"

BUNDLE_DIR="$INSTALLER_DIR/bundles"



##################################################
# Libraries
##################################################

source "$SCRIPT_DIR/util.sh"
source "$SCRIPT_DIR/chroot.sh"



##################################################
# Find Bundle File
##################################################

bundle_file() {

    local BUNDLE="$1"


    echo "$BUNDLE_DIR/$BUNDLE.txt"

}



##################################################
# Check Bundle Exists
##################################################

bundle_exists() {

    local FILE

    FILE="$(bundle_file "$1")"


    [[ -f "$FILE" ]]

}



##################################################
# Read Bundle Packages
##################################################

bundle_packages() {

    local BUNDLE="$1"

    local FILE


    FILE="$(bundle_file "$BUNDLE")"



    if [[ ! -f "$FILE" ]]; then

        log "Bundle not found: $FILE"

        return 1

    fi



    grep -v '^#' "$FILE" \
        | grep -v '^$'


}



##################################################
# Install Bundle
##################################################

bundle_install() {

    local BUNDLE="$1"



    if ! bundle_exists "$BUNDLE"; then

        log "Missing bundle: $BUNDLE"

        return 1

    fi



    log "Installing bundle: $BUNDLE"



    local PACKAGES


    PACKAGES="$(bundle_packages "$BUNDLE")"



    if [[ -z "$PACKAGES" ]]; then

        log "Bundle is empty: $BUNDLE"

        return 0

    fi



    chroot_run pacman \
        --noconfirm \
        -S \
        $PACKAGES



}



##################################################
# List Available Bundles
##################################################

bundle_list() {


    for FILE in "$BUNDLE_DIR"/*.txt; do


        basename "$FILE" .txt


    done


}
