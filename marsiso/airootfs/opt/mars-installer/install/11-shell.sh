#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Install Module 11 - Shell Setup
##################################################

set -e


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="$(dirname "$SCRIPT_DIR")"


source "$INSTALLER_DIR/lib/util.sh"
source "$INSTALLER_DIR/lib/config.sh"


main() {

    config_load || die "Missing configuration."


    if [[ -z "$USERNAME" ]]; then
        die "No username configured."
    fi


    log "Installing Oh My Zsh configuration"


    ##################################################
    # User skeleton
    ##################################################

    mkdir -p /mnt/etc/skel/.config


    cp -r \
        /opt/mars-installer/assets/shell/zsh/oh-my-zsh \
        /mnt/etc/skel/.oh-my-zsh


    cp \
        /opt/mars-installer/assets/shell/zsh/zshrc \
        /mnt/etc/skel/.zshrc


    cp \
        /opt/mars-installer/assets/shell/starship.toml \
        /mnt/etc/skel/.config/starship.toml



    ##################################################
    # First user
    ##################################################

    mkdir -p "/mnt/home/$USERNAME/.config"


    cp -r \
        /mnt/etc/skel/.oh-my-zsh \
        "/mnt/home/$USERNAME/"


    cp \
        /mnt/etc/skel/.zshrc \
        "/mnt/home/$USERNAME/"


    cp \
        /mnt/etc/skel/.config/starship.toml \
        "/mnt/home/$USERNAME/.config/"



    arch-chroot /mnt chown -R \
        "$USERNAME:$USERNAME" \
        "/home/$USERNAME"



    log "Shell environment installed."

}


main
