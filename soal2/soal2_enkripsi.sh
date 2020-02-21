#!/bin/bash

normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
last_modified=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
new_name=$(echo "${1%.txt}" | tr ${normal:0:26}${uppercase:0:26} ${normal:last_modified:26}${uppercase:last_modified:26})
cp $1 $new_name".txt"