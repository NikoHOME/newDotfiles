#!/bin/sh

# yay installation script
# https://aur.archlinux.org/yay

./util/install-package.sh git base-devel

./util/clone-repository.sh https://aur.archlinux.org/yay.git yay /tmp/install

cd /tmp/install/yay
makepkg -si
rm -rf /tmp/install/yay
