#!/bin/sh

# Eww installation script
# https://github.com/elkowar/eww



FILE=/bin/eww
if [ -f "$FILE" ]; then
    printf "\n<==[::]==> Build skipped $FILE already exists\n\n"
    exit 0
fi


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

$SCRIPTPATH/../util/install-package.sh rustup

$SCRIPTPATH/../util/clone-repository.sh https://github.com/elkowar/eww eww /tmp

cd /tmp/eww

cargo build --release --no-default-features --features x11

FILE=./target/release/eww
if [ -f "$FILE" ]; then
    printf "\n<==[::]==> Build finished\n\n"
else
    printf "\n<==[%%]==> Build failed\n\n"
    exit 3
fi


$SCRIPTPATH/../util/check-for-file.sh ./target/release/eww

cd target/release

chmod +x ./eww
sudo mv ./eww /bin/eww

rm -rf /tmp/eww

printf "\n<==[::]==> EWW installed successfully\n\n"
