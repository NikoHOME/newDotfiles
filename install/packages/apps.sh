#!/bin/sh

# application packages installation script

Packages=(
    "firefox"
    "gimp"
    "krita"
    "inkscape"
    "libreoffice-fresh"
    "discord"
    "kdenlive"
    "audacity"
)

sudo pacman --needed --noconfirm -Sy ${Packages[@]}
