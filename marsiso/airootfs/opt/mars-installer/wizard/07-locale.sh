MARSYX-MA1% cat lib/ui.sh 
#!/usr/bin/env bash

##################################################
# Mars OS Installer
# Dialog UI Library
##################################################

DIALOG="dialog"

HEIGHT=15
WIDTH=60


##################################################
# Message Box
##################################################

ui_msgbox() {

    local TITLE="$1"
    local MESSAGE="$2"

    $DIALOG \
        --title "$TITLE" \
        --msgbox "$MESSAGE" \
        $HEIGHT \
        $WIDTH

}


##################################################
# Yes/No Prompt
##################################################

ui_yesno() {

    local TITLE="$1"
    local MESSAGE="$2"

    $DIALOG \
        --title "$TITLE" \
        --yesno "$MESSAGE" \
        10 \
        $WIDTH

}


##################################################
# Menu
##################################################

ui_menu() {

    local TITLE="$1"
    local MESSAGE="$2"

    shift 2

    $DIALOG \
        --title "$TITLE" \
        --menu "$MESSAGE" \
        15 \
        $WIDTH \
        8 \
        "$@" \
        3>&1 \
        1>&2 \
        2>&3

}


##################################################
# Input Box
##################################################

ui_input() {

    local TITLE="$1"
    local MESSAGE="$2"
    local DEFAULT="$3"

    $DIALOG \
        --title "$TITLE" \
        --inputbox "$MESSAGE" \
        10 \
        $WIDTH \
        "$DEFAULT" \
        3>&1 \
        1>&2 \
        2>&3

}


##################################################
# Password Box
##################################################

ui_password() {

    local TITLE="$1"
    local MESSAGE="$2"

    $DIALOG \
        --title "$TITLE" \
        --passwordbox "$MESSAGE" \
        10 \
        $WIDTH \
        3>&1 \
        1>&2 \
        2>&3

}


##################################################
# Gauge
##################################################

ui_gauge() {

    $DIALOG \
        --title "Mars OS Installer" \
        --gauge "$1" \
        10 \
        $WIDTH \
        0

}

##################################################
# Menu From File
##################################################

ui_menu_from_file() {

    local TITLE="$1"
    local MESSAGE="$2"
    local FILE="$3"

    local ITEMS=()


    while IFS= read -r LINE; do

        [[ -z "$LINE" ]] && continue

        ITEMS+=(
            "$LINE"
            ""
        )

    done < "$FILE"


    $DIALOG \
        --title "$TITLE" \
        --menu "$MESSAGE" \
        20 \
        70 \
        15 \
        "${ITEMS[@]}" \
        3>&1 \
        1>&2 \
        2>&3

}
