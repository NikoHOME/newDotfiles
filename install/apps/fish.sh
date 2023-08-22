#!/bin/sh

#fish installation script 


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

$SCRIPTPATH/../util/install-package.sh fish

echo /usr/bin/fish | sudo tee -a /etc/shells
sudo chsh -s /usr/bin/fish
chsh -s /usr/bin/fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fish -c "omf install slacker; exit"