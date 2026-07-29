#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Profile Library
##################################################

##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="$(dirname "$SCRIPT_DIR")/profiles"

##################################################
# Libraries
##################################################

source "$SCRIPT_DIR/util.sh"

##################################################
# Load Profile
##################################################

profile_load() {

    local PROFILE="$1"
    local PROFILE_FILE="$PROFILE_DIR/$PROFILE.conf"

    if [[ ! -f "$PROFILE_FILE" ]]; then
        log "Profile not found: $PROFILE_FILE"
        return 1
    fi

    # shellcheck disable=SC1090
    source "$PROFILE_FILE"

}

##################################################
# Validate Profile
##################################################

profile_validate() {

    if [[ -z "$PROFILE_NAME" ]]; then
        log "Profile name missing."
        return 1
    fi

    if [[ -z "$BUNDLES" ]]; then
        log "Profile contains no bundles."
        return 1
    fi

    if [[ -z "$BOOTLOADER" ]]; then
        log "Profile does not define a bootloader."
        return 1
    fi

}

##################################################
# Install / Apply Profile
##################################################

profile_install() {

    local PROFILE="$1"

    profile_load "$PROFILE" || return 1
    profile_validate || return 1

    log "Applying profile: $PROFILE"

    case "$PROFILE" in

        standard)
            profile_standard
            ;;

        kde)
            profile_kde
            ;;

        leite)
            profile_leite
            ;;

        *)
            log "Unknown profile: $PROFILE"
            return 1
            ;;

    esac

}

##################################################
# Common Configuration
##################################################

profile_common() {

    log "Enabling NetworkManager"

    arch-chroot /mnt systemctl enable NetworkManager \
        || return 1

    log "Enabling Ly Display Manager"
    arch-chroot /mnt systemctl enable ly@tty1.service \
        || return 1

}

##################################################
# Standard
##################################################

profile_standard() {

    log "Applying Standard profile"

    profile_common

}

##################################################
# KDE
##################################################

profile_kde() {

    log "Applying KDE profile"

    profile_common

}

##################################################
# Leite
##################################################

profile_leite() {

    log "Applying Leite profile"

    profile_common

}

##################################################
# Show Profile Information
##################################################

profile_show() {

    echo "Profile:"
    echo "$PROFILE_NAME"

    echo

    echo "Desktop:"
    echo "$DESKTOP"

    echo

    echo "Bootloader:"
    echo "$BOOTLOADER"

    echo

    echo "Display Manager:"
    echo "$DISPLAY_MANAGER"

}
