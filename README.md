# SoalShiftSISOP20_modul1_E04

Soal Shift Sistem Operasi 2020\
Modul 1\
Kelompok E 04

## 1. Mengolah Data dari "Sample-Superstore.tsv"
>Source code file: [Soal1](https://github.com/segara2410/SoalShiftSISOP20_modul1_E04/tree/master/soal1)

Soal 1 diselesaikan menggunakan AWK

(a) Solusi:

```
a=$
(awk -F "\t" '
    { if ($13 != "Region") data[$13] += $21 } 
    END 
    { for (datum in data) 
        { print data[datum] " " datum } 
    }

' Sample-Superstore.tsv | sort -nk1 | head -n 1 | grep -oP '(?<=[0-9.] ).*')

echo "Region dengan profit minimum : "$a
```

- `if ($13 != "Region") data[$13] += $21` adalah untuk menambahkan profit dari region yang sama 
- `for (datum in data) { print data[datum] " " datum} ` Mencetak profit beserta regionnya
- `Sample-Superstore.tsv` adalah untuk membuka file.tsv
- `sort -nk1` mensorting berdasarkan kolom
- `head -n 1` mengambil yang paling atas
- `grep -oP '(?<=[0-9.] ).*` mengambil nama region
- `echo "Region dengan profit minimum : "$a` mencetak nama region yang memiliki profit minimum

(b) Solusi:

```
b=$(awk -v a="$a" 
'BEGIN{ FS="\t" } 
{ if ( $13 == a ) 
    { data[$11] += $21 } 
} 
END 
{ print $11 a; for (datum in data) 
    {	print data[datum] " " datum } 
}' 

Sample-Superstore.tsv | sort -nk1 | head -n 2 | grep -oP '(?<=[0-9.] ).*')

b=$(echo "$b" | tr "\n" ";")

b=${b::-1}

echo "State dengan profit minimum : "$b
```
- `if ( $13 == a ) { data[$11] += $21} ` ketika region = a, profit di total
- `b=$(echo "$b" | tr "\n" ";")` memisahkan semua hasil b dengan ";"
- `b=${b::-1}` menghapus ";" terakhir
- `echo "State dengan profit minimum : "$b` Mencetak state dengan profit minimum


(c) Solusi:

```
c=$(awk -v b="$b" 
'BEGIN{	FS="\t"; split(b, check, ";"); } 
{ if ( check[1] == $10 || check[2] == $10 )
    { data[$17] += $21 } 
}
END 
{ for (datum in data) 
    { print data[datum] " " datum } 
}
' Sample-Superstore.tsv | sort -nk1 | head -n 10 | grep -oP '(?<=[0-9.] ).*')

c=$(echo "$c" | tr "\n" ";")

c=${c::-1}

echo "Produk dengan profit minimum : "$c
```

- `split(b, check, ";")` setiap b dimasukkan ke array bernama check
- `if ( check[1] == $10 || check[2] == $10 ){ data[$17] += $21 }` mentotal profit
- `echo "Produk dengan profit minimum : "$c` mencetak produk yang meiliki profit minimum.


## 2. Caesar Cipher
>Source code file: [Soal2](https://github.com/segara2410/SoalShiftSISOP20_modul1_E04/tree/master/soal2)

```
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > `echo $1 | tr -dc 'a-zA-Z'`.txt
```

- `/dev/urandom` mengambil nilai random
- `tr -dc 'a-zA-Z0-9'` mengambil huruf dang angka
- `fold -w 28` mengambil 28 karakter
- `head -n 1` mengambil yang paling atas
- `echo $1 | tr -dc 'a-zA-Z'.txt` memasukkan ke dalam file.txt

Encryption
```
normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
last_modified=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
new_name=$(echo "${1%.txt}" | tr ${normal:0:26}${uppercase:0:26} ${normal:last_modified:26}${uppercase:last_modified:26})

cp $1 $new_name".txt"
```
- `last_modified=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')` mengambil jam last modified dari file
- `new_name=$(echo "${1%.txt}" | tr ${normal:0:26}${uppercase:0:26} ${normal:last_modified:26}${uppercase:last_modified:26})` enkripsi menggunakan jam yang telah diambil
- `cp $1 $new_name".txt"` menduplikasi file dengan nama yang telah di enkripsi

Decryption
```
normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
last_modified=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
new_name=$(echo "${1%.txt}" | tr ${normal:$last_modified:26}${uppercase:$last_modified:26} ${normal:0:26}${uppercase:0:26})

cp $1 $new_name".txt"
```
- `cp $1 $new_name".txt"` menduplikasi file dnegan nama yang telah di dekripsi

## 3. PDKT Kusuma
>source code file: [Soal3](https://github.com/segara2410/SoalShiftSISOP20_modul1_E04/tree/master/soal3)

(a) Solusi:

```
i=$(ls pdkt_kusuma_* 2> /dev/null | grep -Eo '[0-9]+' | sort -rn | head -n 1)
i=`expr $i + 1`
wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat --append-output wget.log >> wget.log
```
- `ls pdkt_kusuma_* 2> /dev/null` melakukan ls tanpa output error
- `grep -Eo '[0-9]+'` mengambil angka dari nama file
- `sort -rn` reverse sort
- ``i=`expr $i + 1`` increment index
- `for ((j = $i ; j < $i+28 ; j++));
  do
    wget -O pdkt_kusuma_$j https://loremflickr.com/320/240/cat --append-output wget.log >> wget.log
  done` melakukan download gambar sebanyak 28 kali dengan penamaan sesuai indeks dan membuat log

(b) Solusi:

```
5 6,14,22 * * 0-5 bash /home/$USER/SoalShiftSISOP20_modul1_E04/soal3/soal3a.sh
```
- `5` bermaksud menit ke-5 setiap jam
- `6,14,22` bermaksud pada jam 6, 14 dan 22 (8 jam sekali)
- `* pertama` bermaksud setiap hari
- `* kedua` bermaksud setiap bulan
- `0-5` bermaksud hari Minggu hingga Jumat
- `bash /home/$USER/SoalShiftSISOP20_modul1_E04/soal3/soal3a.sh` menjalankan script untuk mendownload gambar

(c) Solusi:

```
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
```
- `cat wget.log | grep Location: > location.log` mengambil line yang terdapat `Location:` didalamnya dan membuat log
- `mkdir -p duplicate kenangan` membuat direktori tanpa menampilkan error
- `awk '{ printf("%s %03d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > tmp.log` membuat temporary log yang berisi indeks dan lokasi dari `location.log`
- `awk -F ' ' '{ i = $2+0; if ( loc != $1 ){ loc = $1; cmd = " mv pdkt_kusuma_" i " kenangan/kenangan_" i; }    else{ cmd = "mv pdkt_kusuma_" i " duplicate/duplicate_" i; } system(cmd); }' tmp.log` melakukan pemindahan sesuai hasil sorting dan indeks
- `rm tmp.log` menghapus temporary log
- `for f in *.log; do mv "$f" "${f%.log}.log.bak" done` mengubah semua `.log` menjadi `.log.bak`
