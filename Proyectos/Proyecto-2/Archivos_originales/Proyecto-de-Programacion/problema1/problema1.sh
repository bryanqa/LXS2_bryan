#!/bin/bash

DATA=./hojasDatos
mkdir $DATA/datos_csv

OUT_DATA=$DATA/datos_csv

m=0

for i in `find $DATA -name "*.xls" | sort -n` 

do 
	echo "Procesando archivo $i"

	xls2csv $i > $OUT_DATA/data-$m.csv
	let m=m+1
done 2> error1.log

