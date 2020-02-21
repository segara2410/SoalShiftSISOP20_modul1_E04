#!/bin/bash

cat wget.log | grep Location: > location.log

mkdir -p duplicate kenangan

awk '{ printf("%s %03d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > tmp.log
awk -F ' ' '{ i = $2+0; if ( loc != $1 ){ loc = $1; cmd = " mv pdkt_kusuma_" i " kenangan/kenangan_" i; }
  else{ cmd = "mv pdkt_kusuma_" i " duplicate/duplicate_" i; } system(cmd); }' tmp.log
rm tmp.log

for f in *.log; 
do 
  mv "$f" "${f%.log}.log.bak"
done
