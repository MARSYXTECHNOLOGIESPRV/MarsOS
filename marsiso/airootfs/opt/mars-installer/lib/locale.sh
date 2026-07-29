#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Locale Library
##################################################


##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Configure Locale
##################################################

locale_set() {

    local LOCALE="$1"



    if [[ -z "$LOCALE" ]]; then

        log "No locale supplied."

        return 1

    fi



    log "Enabling locale: $LOCALE"



    if ! grep -q "^#\?${LOCALE} UTF-8" /mnt/etc/locale.gen; then

        log "Locale not found in locale.gen: $LOCALE"

        return 1

    fi



    arch-chroot /mnt /bin/bash -c "
        
        sed -i \
        \"s/^#${LOCALE} UTF-8/${LOCALE} UTF-8/\" \
        /etc/locale.gen


        locale-gen

    "



    cat > /mnt/etc/locale.conf <<EOF
LANG=$LOCALE
EOF



    if [[ ! -f /mnt/etc/locale.conf ]]; then

        log "Failed creating locale.conf"

        return 1

    fi


}
