#!/bin/sh

URL=$1
DIRNAME=$2
DESTINATION=$3

if [ ! -d "$DESTINATION" ]; then
    mkdir $DESTINATION
fi


cd $DESTINATION

git clone $URL



if [ -d "$DIRNAME" ]; then
    printf "\n<==[::]==> $DIRNAME repository cloned\n\n"
else
    printf "\n<==[%%]==> $DIRNAME clone failed\n\n"
    exit 2
fi
