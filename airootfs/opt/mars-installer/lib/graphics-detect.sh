#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Graphics Detection Library
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"


graphics_detect() {

    log "Detecting graphics hardware"



    if ! command -v lspci >/dev/null 2>&1; then

        log "lspci not available"
        return 1

    fi



    GPU_INFO=$(lspci | grep -Ei "VGA|3D|Display")



    if echo "$GPU_INFO" | grep -qi "NVIDIA"; then

        echo "nvidia"
        return 0

    fi



    if echo "$GPU_INFO" | grep -qi "AMD\|ATI"; then

        echo "amd"
        return 0

    fi



    if echo "$GPU_INFO" | grep -qi "Intel"; then

        echo "intel"
        return 0

    fi



    log "Unknown GPU:"
    log "$GPU_INFO"

    echo "vm"

}
