#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# GRUB Bootloader Library
##################################################


##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"



##################################################
# Libraries
##################################################

source "$SCRIPT_DIR/util.sh"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/chroot.sh"



##################################################
# Install GRUB (UEFI)
##################################################

grub_install_uefi() {


    log "Installing GRUB for UEFI"



    chroot_run grub-install \
        --target=x86_64-efi \
        --efi-directory=/boot \
        --bootloader-id=MARSOS \
        --recheck


}



##################################################
# Install GRUB (BIOS)
##################################################

grub_install_bios() {


    log "Installing GRUB for BIOS"



    if [[ -z "$DISK" ]]; then

        log "No disk specified for BIOS GRUB."

        return 1

    fi



    chroot_run grub-install \
        --target=i386-pc \
        "$DISK" \
        --recheck


}



##################################################
# Configure GRUB
##################################################

grub_configure() {


    log "Configuring GRUB"



    chroot_bash "
        
        sed -i \
        's/^#*GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' \
        /etc/default/grub


        grep -q '^GRUB_DISTRIBUTOR=' /etc/default/grub \
        && sed -i \
        's/^GRUB_DISTRIBUTOR=.*/GRUB_DISTRIBUTOR=\"Mars OS\"/' \
        /etc/default/grub \
        || echo 'GRUB_DISTRIBUTOR=\"Mars OS\"' \
        >> /etc/default/grub

    "


}



##################################################
# Generate GRUB Config
##################################################

grub_generate() {


    log "Generating grub.cfg"



    chroot_run grub-mkconfig \
        -o /boot/grub/grub.cfg


}



##################################################
# Main GRUB Install Function
##################################################

grub_install() {


    config_load \
        || return 1



    if [[ -z "$FIRMWARE" ]]; then

        log "Firmware mode not set."

        return 1

    fi



    case "$FIRMWARE" in


        uefi)

            grub_install_uefi \
                || return 1

            ;;


        bios)

            grub_install_bios \
                || return 1

            ;;


        *)

            log "Unknown firmware mode: $FIRMWARE"

            return 1

            ;;

    esac



    grub_configure \
        || return 1



    grub_generate \
        || return 1


}
