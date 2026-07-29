#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Hostname Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Set Hostname
##################################################

hostname_set() {

    local NAME="$1"



    if [[ -z "$NAME" ]]; then

        log "Hostname is empty."

        return 1

    fi



    log "Writing hostname"



    printf "%s\n" "$NAME" \
        > /mnt/etc/hostname



    log "Writing hosts file"



    cat > /mnt/etc/hosts <<EOF
127.0.0.1       localhost
::1             localhost
127.0.1.1       $NAME.localdomain $NAME
EOF



    if [[ ! -f /mnt/etc/hostname ]]; then

        log "Failed creating hostname file."

        return 1

    fi


}
