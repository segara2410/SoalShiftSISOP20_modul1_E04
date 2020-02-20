#!/bin/bash

normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
name=$(echo "${1%.txt}" | tr ${normal:$amt:26}${uppercase:$amt:26} ${normal:0:26}${uppercase:0:26})
cp $1 $name".txt"