#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# User Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Create User
##################################################

users_create() {

    local USER="$1"
    local USER_PASS="$2"
    local ROOT_PASS="$3"



    if [[ -z "$USER" ]]; then

        log "Missing username."

        return 1

    fi



    log "Creating user account: $USER"



    if arch-chroot /mnt id "$USER" >/dev/null 2>&1; then

        log "User already exists."

        return 1

    fi



    arch-chroot /mnt useradd \
        -m \
        -G wheel \
        -s /bin/bash \
        "$USER"



    ##################################################
    # User Password
    ##################################################

    if [[ -z "$USER_PASS" ]]; then


        log "No user password supplied."

        arch-chroot /mnt passwd -d "$USER"


    else


        log "Setting user password"



        printf "%s:%s\n" "$USER" "$USER_PASS" | \
            arch-chroot /mnt chpasswd


    fi



    ##################################################
    # Root Password
    ##################################################

    if [[ -z "$ROOT_PASS" ]]; then


        log "No root password supplied."

        arch-chroot /mnt passwd -d root


    else


        log "Setting root password"



        printf "root:%s\n" "$ROOT_PASS" | \
            arch-chroot /mnt chpasswd


    fi



    ##################################################
    # Enable sudo for wheel group
    ##################################################

    log "Enabling wheel sudo"



    arch-chroot /mnt /bin/bash -c "
        sed -i \
        's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' \
        /etc/sudoers
    "



}
