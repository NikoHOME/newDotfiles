#!/bin/sh

# application packages installation script

Packages=(
    "firefox"
    "gimp"
    "krita"
    "inkscape"
    "libreoffice-fresh"
    "qt"
    "discord"
    "kdenlive"
    "audacity"
)

yay --needed --noconfirm -Sy ${Packages[@]}
