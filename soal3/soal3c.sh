#!/bin/bash

cat wget.log | grep Location: > location.log

mkdir -p duplicate kenangan

awk '{ print i + 1 ";" $2; i += 1 }' location.log | sort -nk2 > tmp.log
awk -F ';' '{ if (i != $2 ){ i = $2; cmd = " mv pdkt_kusuma_" $1 " kenangan/kenangan_" $1; }
  else{ cmd = "mv pdkt_kusuma_" $1 " duplicate/duplicate_" $1; } system(cmd); }' tmp.log
rm tmp.log

for f in *.log; 
do 
  mv "$f" "${f%.log}.log.bak"
done