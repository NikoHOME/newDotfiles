#!/bin/sh

# Eww installation script
# https://github.com/elkowar/eww

./install-package.sh rustup

./clone-repository.sh https://github.com/elkowar/eww eww /tmp

cd /tmp/eww

cargo build --release --no-default-features --features x11

./check-for-file.sh ./target/release/eww

cd target/release

chmod +x ./eww
sudo mv ./eww /bin/eww

rm -rf /tmp/eww

printf "\n<==[::]==> EWW installed successfully\n\n"
