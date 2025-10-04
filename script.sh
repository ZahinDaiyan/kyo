#!/bin/bash
id=$(date)
echo $id

fileName="{$1}""-""${id}"
echo $fileName

mkdir /home/zahin/dev/kyo/snapshots/$fileName

dir= $PWD
echo $dir

echo "$dir" "*"
cp -r $"dir""*" /home/zahin/dev/kyo/snapshots/fileName



