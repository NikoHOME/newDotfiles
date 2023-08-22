#!/bin/sh

# yay installation script
# https://aur.archlinux.org/yay

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

$SCRIPTPATH/../util/install-package.sh git base-devel

$SCRIPTPATH/../util/clone-repository.sh https://aur.archlinux.org/yay.git yay /tmp/install

cd /tmp/install/yay
makepkg -si
rm -rf /tmp/install/yay
