#!/bin/bash

a=$(awk -F "\t" '{ if ($13 != "Region") data[$13] += $21 } END { for (datum in data) { print data[datum] " " datum } }' Sample-Superstore.tsv | sort -nk1 | head -n 1 | grep -oP '(?<=[0-9.] ).*')
echo "Region dengan profit minimum : "$a

b=$(awk -v a="$a" 'BEGIN{ FS="\t" } { if ( $13 == a ) { data[$11] += $21 } } END { print $11 a; for (datum in data) {	print data[datum] " " datum } }' Sample-Superstore.tsv | sort -nk1 | head -n 2 | grep -oP '(?<=[0-9.] ).*')
b=$(echo "$b" | tr "\n" ";")
b=${b::-1}
echo "State dengan profit minimum : "$b

c=$(awk -v b="$b" 'BEGIN{	FS="\t"; split(b, check, ";"); } { if ( check[1] == $11 || check[2] == $11 ){ data[$17] += $21 } } END { for (datum in data) { print data[datum] " " datum } }' Sample-Superstore.tsv | sort -nk1 | head -n 10 | grep -oP '(?<=[0-9.] ).*')
c=$(echo "$c" | tr "\n" ";")
c=${c::-1}
echo "Produk dengan profit minimum : "$c