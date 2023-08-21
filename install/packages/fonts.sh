#!/bin/sh

# font packages installation script

Packages=(
    "ttf-ubuntu-font-family"
    "ttf-font-awesome"
    "ttf-jetbrains-mono"
    "noto-fonts"
    "noto-fonts-emoji"
    "noto-fonts-cjk"
    "noto-fonts-extra"
    "ttf-linux-libertine"
    "ttf-dejavu"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-mono"
    "ttf-material-design-iconic-font"
)

yay --needed --noconfirm -Sy ${Packages[@]}
