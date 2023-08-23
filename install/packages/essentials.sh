#!/bin/sh

# Essential packages installation script

Packages=(
    "pipewire-pulse"
    "lightdm"
    "ranger"
    "git"
    "neofetch"
    "neovim"
    "fish"
    "dmenu"
    "rofi"
    "python"
    "python-psutil"
    "python-iwlib"
    "imagemagick"
    "bc"
    "alsa-utils"
    "xorg-mkfontdir"
    "xorg"
    "htop"
    "scrot"
    "udisks2"
    "udiskie"
    "ntfs-3g" 
    "pavucontrol"
    "networkmanager"
    "nm-connection-editor"
    "eog"
    "mpv"
    "inetutils"
    "unzip"
    "galculator"
    "refind"
    "efibootmgr"
    "bspwm"
    "trayer-srg"
    "feh"
    "dolphin"
    "lxappearance"
    "gnome-themes-extra"
)

Packages_AUR=(
    "lightdm-settings"
    "lightdm-slick-greeter"
    "picom-allusive"
    "qt5-style-plugins"
    "beautyline"
    "kimi-dark-gtk-theme-git"
    "qt5-styleplugins"
)

sudo pacman --needed --noconfirm -Sy ${Packages[@]}
yay --needed --noconfirm -Sy ${Packages_AUR[@]}
