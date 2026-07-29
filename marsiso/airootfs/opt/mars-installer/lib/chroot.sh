#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Chroot Library
##################################################

##################################################
# Requires:
# lib/util.sh
##################################################

source "$(dirname "${BASH_SOURCE[0]}")/util.sh"



##################################################
# Run Command In Installed System
##################################################

chroot_run() {

    arch-chroot /mnt "$@"

}



##################################################
# Run Shell Command In Installed System
##################################################

chroot_bash() {

    arch-chroot /mnt /bin/bash -c "$1"

}
