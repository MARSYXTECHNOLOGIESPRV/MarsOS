#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Timezone Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Set Timezone
##################################################

timezone_set() {

    local ZONE="$1"



    if [[ ! -f "/usr/share/zoneinfo/$ZONE" ]]; then

        log "Invalid timezone: $ZONE"

        return 1

    fi



    log "Setting timezone: $ZONE"



    arch-chroot /mnt ln -sf \
        "/usr/share/zoneinfo/$ZONE" \
        /etc/localtime



    arch-chroot /mnt hwclock \
        --systohc

}
