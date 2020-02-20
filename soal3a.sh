#!/bin/bash

i=$(ls -q pdkt_kusuma_* | grep -Eo '[0-9]+' | sort -rn | head -n 1)
i=`expr $i + 1`
wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat --append-output wget.log >> wget.log