#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 03 - Pacstrap
##################################################

set -eo pipefail


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
source "$INSTALLER_DIR/lib/bundles.sh"
source "$INSTALLER_DIR/lib/profiles.sh"
source "$INSTALLER_DIR/lib/graphics-detect.sh"



##################################################
# Main
##################################################

main() {


    config_load || die "Missing install configuration."



    if [[ -z "$PROFILE" ]]; then

        die "No profile selected."

    fi



    if [[ -z "$GRAPHICS" ]]; then

        die "No graphics profile selected."

    fi



    ##################################################
    # Base Packages
    ##################################################

    BASE_PACKAGES=(
        base
        linux
        linux-firmware
        mkinitcpio
    )



    PACKAGES=(
        "${BASE_PACKAGES[@]}"
    )



    ##################################################
    # Load Profile
    ##################################################

    profile_load \
        "$PROFILE" \
        || die "Failed loading profile."



    if [[ -z "$BUNDLES" ]]; then

        die "Profile contains no package bundles."

    fi



    ##################################################
    # Profile Bundles
    ##################################################

    for BUNDLE in $BUNDLES; do


        log "Loading profile bundle: $BUNDLE"



        BUNDLE_PACKAGES=$(bundle_packages "$BUNDLE")



        if [[ -z "$BUNDLE_PACKAGES" ]]; then

            die "Failed loading bundle: $BUNDLE"

        fi



        PACKAGES+=(
            $BUNDLE_PACKAGES
        )


    done



    ##################################################
    # Graphics Bundle
    ##################################################

    if [[ "$GRAPHICS" == "auto" ]]; then


        log "Automatically detecting graphics hardware"



        GRAPHICS=$(graphics_detect) \
            || die "Graphics detection failed."



        log "Detected graphics profile: $GRAPHICS"


    fi



    log "Loading graphics bundle: $GRAPHICS"



    GRAPHICS_PACKAGES=$(bundle_packages "$GRAPHICS")



    if [[ -z "$GRAPHICS_PACKAGES" ]]; then

        die "Failed loading graphics bundle: $GRAPHICS"

    fi



    PACKAGES+=(
        $GRAPHICS_PACKAGES
    )



    ##################################################
    # Bootloader Bundle
    ##################################################

    if [[ "$BOOTLOADER" == "grub" ]]; then


        log "Loading GRUB bundle"



        GRUB_PACKAGES=$(bundle_packages grub)



        if [[ -z "$GRUB_PACKAGES" ]]; then

            die "Failed loading GRUB bundle."

        fi



        PACKAGES+=(
            $GRUB_PACKAGES
        )


    fi



    ##################################################
    # Remove Duplicates
    ##################################################

    PACKAGES=(
        $(printf "%s\n" "${PACKAGES[@]}" | sort -u)
    )



##################################################
# Install Packages
##################################################

log "Installing packages:"
log "${PACKAGES[*]}"

log "Generating mirror list..."

reflector \
    --latest 20 \
    --protocol https \
    --sort rate \
    --save /etc/pacman.d/mirrorlist \
    || die "Failed to generate mirror list."

log "Refreshing package databases..."

pacman -Syy \
    || die "Failed to synchronize package databases."

log "Running pacstrap..."

pacstrap \
    -K \
    /mnt \
    "${PACKAGES[@]}" \
    2>&1 | tee -a "$LOG_FILE" \
    || die "Pacstrap failed.

Check:
$LOG_FILE"

success \
"Base system installed successfully."

}



main
