#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# systemd-boot Library
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
source "$SCRIPT_DIR/filesystem.sh"



##################################################
# Install systemd-boot
##################################################

systemd_boot_install() {


    config_load \
        || return 1



    if [[ -z "$FIRMWARE" ]]; then

        log "Firmware mode not set."

        return 1

    fi



    case "$FIRMWARE" in


        uefi)

            log "Installing systemd-boot"



            chroot_run bootctl \
                --path=/boot \
                install \
                || return 1

            ;;


        bios)

            log "systemd-boot does not support BIOS."

            return 1

            ;;


        *)

            log "Unknown firmware mode: $FIRMWARE"

            return 1

            ;;

    esac



    systemd_boot_configure \
        || return 1


}



##################################################
# Configure systemd-boot
##################################################

systemd_boot_configure() {


    log "Creating systemd-boot configuration"



    local ROOT_PART



    ROOT_PART=$(filesystem_get_root)



    if [[ -z "$ROOT_PART" ]]; then

        log "Unable to determine root partition."

        return 1

    fi



    local ROOT_UUID



    ROOT_UUID=$(blkid \
        -s PARTUUID \
        -o value \
        "$ROOT_PART"
    )



    if [[ -z "$ROOT_UUID" ]]; then

        log "Unable to determine root PARTUUID."

        return 1

    fi



    mkdir -p /mnt/boot/loader/entries



    cat > /mnt/boot/loader/loader.conf <<EOF
default marsos
timeout 3
editor no
EOF



    cat > /mnt/boot/loader/entries/marsos.conf <<EOF
title   Mars OS
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=$ROOT_UUID rw
EOF



}
