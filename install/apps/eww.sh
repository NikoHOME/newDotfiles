#!/bin/sh

# Eww installation script
# https://github.com/elkowar/eww


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

$SCRIPTPATH/../util/install-package.sh rustup

$SCRIPTPATH/../util/clone-repository.sh https://github.com/elkowar/eww eww /tmp

cd /tmp/eww

cargo build --release --no-default-features --features x11

$SCRIPTPATH/../util/check-for-file.sh ./target/release/eww

cd target/release

chmod +x ./eww
sudo mv ./eww /bin/eww

rm -rf /tmp/eww

printf "\n<==[::]==> EWW installed successfully\n\n"
