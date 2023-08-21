#!/bin/sh

# rofi theme installation script
# https://github.com/catppuccin/rofi

./install-package.sh rofi

./clone-repository.sh https://github.com/catppuccin/rofi.git rofi /tmp

cd /tmp/rofi/basic

chmod +x install.sh
./install.sh

rm -rf /tmp/rofi