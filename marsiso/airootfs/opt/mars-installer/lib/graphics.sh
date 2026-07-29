#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Graphics Library
##################################################


##################################################
# Requires:
# bundles.sh
# util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"
source "$(dirname "${BASH_SOURCE[0]}")/bundles.sh"



##################################################
# Install Graphics Bundle
##################################################

graphics_install() {

    local GPU="$1"
    local BUNDLE=""


    case "$GPU" in


        amd)

            BUNDLE="amd"
            ;;


        intel)

            BUNDLE="intel"
            ;;


        nvidia)

            BUNDLE="nvidia"
            ;;


        vm)

            BUNDLE="vm"
            ;;


        *)

            log "Unknown graphics option: $GPU"

            return 1
            ;;

    esac



    log "Loading graphics bundle: $BUNDLE"



    bundle_install \
        "$BUNDLE"

}
