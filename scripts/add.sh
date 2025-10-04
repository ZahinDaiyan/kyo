#!/bin/bash

dateTime=$(date +"%d-%B_%H-%M-%S")
newSnapName="$1-${dateTime}"
mkdir /home/zahin/dev/kyo-version-control-system/snapshots/$newSnapName

current_pwd=$PWD
cp -r "${current_pwd}""/" /home/zahin/dev/kyo-version-control-system/snapshots/$newSnapName
echo "File Saved."
