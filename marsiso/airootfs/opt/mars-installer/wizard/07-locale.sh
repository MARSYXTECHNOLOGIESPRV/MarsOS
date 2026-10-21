#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="$(dirname "$SCRIPT_DIR")"

source "$INSTALLER_DIR/lib/config.sh"
source "$INSTALLER_DIR/lib/ui.sh"

config_set LOCALE "en_US.UTF-8"

ui_msgbox \
    "Locale" \
    "Using the default locale: en_US.UTF-8"