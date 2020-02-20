#!/bin/bash

normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
name=$(echo "${1%.txt}" | tr ${normal:0:26}${uppercase:0:26} ${normal:`date +%-H`:26}${uppercase:`date +%-H`:26})
cp $1 $name".txt"