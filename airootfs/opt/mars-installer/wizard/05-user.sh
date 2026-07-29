#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Wizard Module 05 - User Setup
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

source "$INSTALLER_DIR/lib/ui.sh"
source "$INSTALLER_DIR/lib/util.sh"
source "$INSTALLER_DIR/lib/config.sh"



##################################################
# Validation
##################################################

valid_username() {

    local USER="$1"

    [[ ${#USER} -ge 1 && ${#USER} -le 32 ]] || return 1
    [[ "$USER" =~ ^[a-z_][a-z0-9_-]*$ ]] || return 1

    return 0

}



##################################################
# Main
##################################################

main() {

    local USERNAME
    local USER_PASSWORD
    local PASSWORD_CONFIRM
    local ROOT_PASSWORD
    local ROOT_CONFIRM



    ##################################################
    # Username
    ##################################################

    while true; do

        USERNAME=$(ui_input \
            "User Account" \
            "Enter your username:" \
            "user")


        [[ $? -eq 0 ]] || die "User creation cancelled."


        if valid_username "$USERNAME"; then
            break
        fi


        ui_msgbox \
            "Invalid Username" \
"Usernames must:

• Start with lowercase letter or _
• Only contain:
  lowercase letters
  numbers
  underscores
  hyphens
• Maximum 32 characters"

    done



    ##################################################
    # User Password
    ##################################################

    while true; do

        USER_PASSWORD=$(ui_password \
            "User Password" \
            "Enter a password for $USERNAME.

Leave blank for no password.")


        [[ $? -eq 0 ]] || die "User creation cancelled."


        if [[ -z "$USER_PASSWORD" ]]; then

            ui_msgbox \
                "No User Password" \
                "The account will have no password."

            break

        fi



        PASSWORD_CONFIRM=$(ui_password \
            "Confirm Password" \
            "Re-enter the password")


        [[ $? -eq 0 ]] || die "User creation cancelled."



        if [[ "$USER_PASSWORD" == "$PASSWORD_CONFIRM" ]]; then
            break
        fi


        ui_msgbox \
            "Passwords Do Not Match" \
            "Please try again."

    done



    ##################################################
    # Root Password
    ##################################################

    while true; do

        ROOT_PASSWORD=$(ui_password \
            "Root Password" \
            "Enter the root password.

Leave blank for no password.")


        [[ $? -eq 0 ]] || die "User creation cancelled."



        if [[ -z "$ROOT_PASSWORD" ]]; then

            ui_msgbox \
                "No Root Password" \
                "Root will have no password."

            break

        fi



        ROOT_CONFIRM=$(ui_password \
            "Confirm Root Password" \
            "Re-enter the root password")


        [[ $? -eq 0 ]] || die "User creation cancelled."



        if [[ "$ROOT_PASSWORD" == "$ROOT_CONFIRM" ]]; then
            break
        fi


        ui_msgbox \
            "Passwords Do Not Match" \
            "Please try again."

    done



    ##################################################
    # Save Configuration
    ##################################################

    config_set USERNAME "$USERNAME"
    config_set USER_PASSWORD "$USER_PASSWORD"
    config_set ROOT_PASSWORD "$ROOT_PASSWORD"



    ui_msgbox \
        "User Created" \
"Username:

$USERNAME

has been configured."

}



main
