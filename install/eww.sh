#!/bin/sh

# Eww installation script
# https://github.com/elkowar/eww

package=rustup
sudo yay -S $package --nocleanmenu --nodiffmenu --noconfirm

if pacman -Qs $package > /dev/null ; then
    printf "\n<==[::]==> Rustup installed\n\n"
else
    printf "\n<==[%%]==> Rustup installation failed\n\n"
    exit 1
fi

git clone https://github.com/elkowar/eww

DIR=./eww
if [ -d "$DIR" ]; then
    printf "\n<==[::]==> Repository cloned\n\n"
else
    printf "\n<==[%%]==> Repository clone failed\n\n"
    exit 2
fi

mv eww /tmp/eww 
cd /tmp/eww

cargo build --release --no-default-features --features x11

FILE=./target/release/eww
if [ -f "$FILE" ]; then
    printf "\n<==[::]==> Build finished\n\n"
else
    printf "\n<==[%%]==> Build failed\n\n"
    exit 3
fi

cd target/release

chmod +x ./eww
sudo mv ./eww /bin/eww

rm -rf /tmp/eww

printf "\n<==[::]==> EWW installed successfully\n\n"
