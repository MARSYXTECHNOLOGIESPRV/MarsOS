#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Configuration Library
##################################################


##################################################
# Paths
##################################################

CONFIG_DIR="/tmp/mars-installer"

CONFIG_FILE="$CONFIG_DIR/install.conf"



##################################################
# Initialize Config
##################################################

config_init() {

    mkdir -p "$CONFIG_DIR"

    if [[ ! -f "$CONFIG_FILE" ]]; then

        touch "$CONFIG_FILE"

    fi

}



##################################################
# Clear Config
##################################################

config_clear() {

    config_init

    > "$CONFIG_FILE"

}



##################################################
# Set Configuration Value
##################################################

config_set() {

    local KEY="$1"
    local VALUE="$2"


    config_init


    # Remove old value

    sed -i \
        "/^${KEY}=/d" \
        "$CONFIG_FILE"



    # Write new value

    printf '%s="%s"\n' \
        "$KEY" \
        "$VALUE" \
        >> "$CONFIG_FILE"

}



##################################################
# Get Configuration Value
##################################################

config_get() {

    local KEY="$1"


    if [[ ! -f "$CONFIG_FILE" ]]; then

        return 1

    fi


    grep "^${KEY}=" "$CONFIG_FILE" \
        | cut -d '=' -f2- \
        | sed 's/^"//;s/"$//'

}



##################################################
# Load Configuration
##################################################

config_load() {


    if [[ ! -f "$CONFIG_FILE" ]]; then

        return 1

    fi


    # shellcheck disable=SC1090

    source "$CONFIG_FILE"

}



##################################################
# Check Configuration Key
##################################################

config_exists() {

    local KEY="$1"


    [[ -f "$CONFIG_FILE" ]] || return 1


    grep -q "^${KEY}=" "$CONFIG_FILE"

}



##################################################
# Require Configuration Key
##################################################

config_require() {

    local KEY="$1"


    if ! config_exists "$KEY"; then

        log "Missing configuration value: $KEY"

        return 1

    fi

}



##################################################
# Show Configuration
##################################################

config_show() {


    if [[ ! -f "$CONFIG_FILE" ]]; then

        echo "No configuration exists."

        return 1

    fi


    cat "$CONFIG_FILE"

}
