#!/usr/bin/env bash

##################################################
# Mars OS Installer v1.1
# Utility Library
##################################################

LOG_FILE="/tmp/mars-installer.log"


##################################################
# Logging
##################################################

log() {

    local MESSAGE="$1"

    mkdir -p "$(dirname "$LOG_FILE")"

    echo "[$(date '+%H:%M:%S')] $MESSAGE" >> "$LOG_FILE"

}


##################################################
# Fatal Error
##################################################

die() {

    local MESSAGE="$1"

    log "ERROR: $MESSAGE"

    echo
    echo "Mars OS Installer Error"
    echo
    echo "$MESSAGE"
    echo

    exit 1

}

##################################################
# Success Message
##################################################

success() {

    local MESSAGE="$1"

    log "SUCCESS: $MESSAGE"

    echo
    echo "$MESSAGE"
    echo

}

##################################################
# Command Validation
##################################################

require_command() {

    if ! command -v "$1" >/dev/null 2>&1; then

        die "Required command missing: $1"

    fi

}
