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
# Check Wi-Fi Tool
##################################################

network_has_iwctl() {

    command -v iwctl >/dev/null 2>&1

}



##################################################
# Start Wi-Fi Configuration
##################################################

network_wifi_setup() {


    if ! network_has_iwctl; then

        log "iwctl not available."

        return 1

    fi



    iwctl

}
