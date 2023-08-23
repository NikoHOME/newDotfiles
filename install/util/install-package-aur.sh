#!/bin/sh

packageName=$1
packages=""

for n in $(seq 1 $#); do
    package="${package} $1" 
    shift
done


yay -S $packages --nocleanmenu --nodiffmenu --noconfirm --needed

if pacman -Qs $packageName > /dev/null ; then
    printf "\n<==[::]==> $packageName installed\n\n"
else
    printf "\n<==[%%]==> $packageName installation failed\n\n"
    exit 1
fi