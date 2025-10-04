#!/bin/bash
#cp -r /home/zahin/dev/kyo-version-control-system/snapshots/test-04-October_22-17-47/* /home/zahin/dev/test/
#rm -r 4312

path=$PWD
nPath=${path%/*}
rm -r ${nPath}
cp -r home/zahin/dev/kyo-version-control-system/snapshots/$1/* ${nPath}
echo "Restoration Succesfull"
