#!/bin/sh

# aditional personal packages installation script

Packages=(
    "visual-studio-code-bin"
    "onedrive-abraunegg"
)

yay --needed --noconfirm -Sy ${Packages[@]}
