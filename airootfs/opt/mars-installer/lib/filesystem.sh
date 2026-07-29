#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Filesystem Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"

##################################################
# Partition Getters
##################################################

filesystem_get_root() {

    config_load || return 1

    echo "$ROOT_PARTITION"

}



filesystem_get_swap() {

    config_load || return 1

    echo "$SWAP_PARTITION"

}



filesystem_get_efi() {

    config_load || return 1

    echo "$EFI_PARTITION"

}

##################################################
# Formatting
##################################################

filesystem_format_root() {

    local PARTITION="$1"


    log "Formatting root filesystem: $PARTITION"


    mkfs.ext4 \
        -F \
        "$PARTITION"

}



filesystem_format_swap() {

    local PARTITION="$1"


    log "Creating swap filesystem: $PARTITION"


    mkswap \
        "$PARTITION"

}



filesystem_format_efi() {

    local PARTITION="$1"


    log "Formatting EFI filesystem: $PARTITION"


    mkfs.fat \
        -F32 \
        "$PARTITION"

}



##################################################
# Mounting
##################################################

filesystem_mount_root() {

    local PARTITION="$1"


    log "Mounting root filesystem"


    mount \
        "$PARTITION" \
        /mnt

}



filesystem_mount_efi() {

    local PARTITION="$1"


    log "Mounting EFI filesystem"


    mkdir -p /mnt/boot


    mount \
        "$PARTITION" \
        /mnt/boot

}



##################################################
# Swap
##################################################

filesystem_enable_swap() {

    local PARTITION="$1"


    log "Enabling swap"


    swapon \
        "$PARTITION"

}



##################################################
# Cleanup Helpers
##################################################

filesystem_unmount_all() {


    log "Unmounting filesystems"


    swapoff \
        -a \
        2>/dev/null || true


    umount \
        -R \
        /mnt \
        2>/dev/null || true

}
