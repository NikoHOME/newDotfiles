#!/bin/sh

# Eww installation script
# https://github.com/elkowar/eww

./util/install-package.sh rustup

./util/clone-repository.sh https://github.com/elkowar/eww eww /tmp

cd /tmp/eww

cargo build --release --no-default-features --features x11

./util/check-for-file.sh ./target/release/eww

cd target/release

chmod +x ./eww
sudo mv ./eww /bin/eww

rm -rf /tmp/eww

printf "\n<==[::]==> EWW installed successfully\n\n"
