#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Partition Library
##################################################


##################################################
# Requires:
# lib/config.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"



##################################################
# UEFI Partitioning
##################################################

partition_uefi() {

    local DISK="$1"


    log "Creating GPT partition table"


    parted \
        --script \
        "$DISK" \
        mklabel gpt



    log "Creating EFI partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        ESP \
        fat32 \
        1MiB \
        1025MiB



    parted \
        --script \
        "$DISK" \
        set \
        1 \
        esp \
        on



    log "Creating swap partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        swap \
        linux-swap \
        1025MiB \
        9217MiB



    log "Creating root partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        root \
        ext4 \
        9217MiB \
        100%


}



##################################################
# BIOS Partitioning
##################################################

partition_bios() {

    local DISK="$1"


    log "Creating MBR partition table"


    parted \
        --script \
        "$DISK" \
        mklabel msdos



    log "Creating BIOS boot partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        primary \
        1MiB \
        3MiB



    parted \
        --script \
        "$DISK" \
        set \
        1 \
        bios_grub \
        on



    log "Creating swap partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        primary \
        linux-swap \
        3MiB \
        8195MiB



    log "Creating root partition"


    parted \
        --script \
        "$DISK" \
        mkpart \
        primary \
        ext4 \
        8195MiB \
        100%


}



##################################################
# Save Partition Information
##################################################

partition_save_state() {

    local DISK="$1"
    local MODE="$2"


    partprobe "$DISK"

    sleep 3



    local PREFIX


    if [[ "$DISK" == *"nvme"* ]]; then

        PREFIX="${DISK}p"

    else

        PREFIX="$DISK"

    fi



    if [[ "$MODE" == "uefi" ]]; then


        config_set EFI_PARTITION "${PREFIX}1"

        config_set SWAP_PARTITION "${PREFIX}2"

        config_set ROOT_PARTITION "${PREFIX}3"



    else


        config_set SWAP_PARTITION "${PREFIX}2"

        config_set ROOT_PARTITION "${PREFIX}3"


    fi

}
