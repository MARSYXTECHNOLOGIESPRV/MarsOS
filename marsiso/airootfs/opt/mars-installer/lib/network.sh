#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Network Library
##################################################


##################################################
# Check Internet Connection
##################################################

network_online() {

    ping \
        -c 1 \
        -W 2 \
        archlinux.org \
        >/dev/null 2>&1

}



##################################################
# Start NetworkManager
##################################################

network_manager_start() {

    systemctl start NetworkManager \
        >/dev/null 2>&1

}



##################################################
# Check NetworkManager Text UI
##################################################

network_has_nmtui() {

    command -v nmtui >/dev/null 2>&1

}



##################################################
# Start Network Configuration
##################################################

network_setup() {

    if ! network_has_nmtui; then

        log "nmtui not available."

        return 1

    fi


    network_manager_start \
        || return 1


    nmtui

}
