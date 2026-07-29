#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 13 - Finish Installation
##################################################

set -e


##################################################
# Paths
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="$(dirname "$SCRIPT_DIR")"



##################################################
# Libraries
##################################################

source "$INSTALLER_DIR/lib/util.sh"
source "$INSTALLER_DIR/lib/config.sh"
source "$INSTALLER_DIR/lib/chroot.sh"



##################################################
# Main
##################################################

main() {


    config_load \
        || die "Missing installation configuration."



    log "Finalizing Mars OS installation"



    ##################################################
    # Enable NetworkManager
    ##################################################

    log "Enabling NetworkManager"



    chroot_run systemctl enable NetworkManager \
        || die "Failed enabling NetworkManager"



    ##################################################
    # Enable Display Manager
    ##################################################

    log "Enabling display manager"



    if [[ -n "$PROFILE" ]]; then


        case "$PROFILE" in


            standard)

                chroot_run systemctl enable greetd \
                    2>/dev/null || true

                ;;


            kde)

                chroot_run systemctl enable sddm \
                    2>/dev/null || true

                ;;


            leite)

                chroot_run systemctl enable sddm \
                    2>/dev/null || true

                ;;


        esac


    fi



    ##################################################
    # Cleanup
    ##################################################

    log "Cleaning package cache"



    chroot_run pacman \
        -Sc \
        --noconfirm \
        2>/dev/null || true



    ##################################################
    # Disable Swap
    ##################################################

    log "Disabling swap"



    swapoff \
        -a \
        2>/dev/null || true



    ##################################################
    # Unmount
    ##################################################

    log "Unmounting filesystems"



    umount \
        -R \
        /mnt \
        2>/dev/null || true



    success \
"\
Mars OS installation complete.

Remove the installation media
and reboot into your new system.
"

}



main
