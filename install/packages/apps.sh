#!/bin/sh

# application packages installation script

Packages=(
    "firefox"
    "libreoffice-fresh"
    "audacity"
)

sudo pacman --needed --noconfirm -Sy ${Packages[@]}
