#!/bin/sh

# rofi theme installation script
# https://github.com/catppuccin/rofi

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

$SCRIPTPATH/../util/install-package.sh rofi

$SCRIPTPATH/../util/clone-repository.sh https://github.com/catppuccin/rofi.git rofi /tmp

cd /tmp/rofi/basic

chmod +x install.sh
./install.sh

rm -rf /tmp/rofi