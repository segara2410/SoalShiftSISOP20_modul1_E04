#!/bin/bash

i=$(ls pdkt_kusuma_* 2> /dev/null | grep -Eo '[0-9]+' | sort -rn | head -n 1)
i=`expr $i + 1`

for ((j = $i ; j < $i+28 ; j++));
do
  wget -O pdkt_kusuma_$j https://loremflickr.com/320/240/cat --append-output wget.log >> wget.log
done