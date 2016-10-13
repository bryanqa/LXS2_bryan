#!/bin/bash

DATA=./hojasDatos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
FULL_DATA=$DATA/full_datos
mkdir $DATA/datos_csv
mkdir $GRAF_DATA
mkdir $FULL_DATA
m=0

for i in `find $DATA -name "*.xls" | sort -n` 

do 
	echo "Procesando archivo $i"

	xls2csv $i > $OUT_DATA/data-$m.csv
	let m=m+1
done 2> error1.log

m=0

for e in `find $OUT_DATA -name "*.csv" | sort -n`
do
	echo "Dando formato de datos para graficar el archivo $e"
	cat $e | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5 " "}' |sed '1,$ s/"//g'| sed '1,$ s/date/#date/g' > $GRAF_DATA/graf-$m.dat
					let m=m+1
done 2> error2.log


#CREANDO GRAFICOS DE TODOS LOS DATOS

if [ -a $FULL_DATA/full.dat ]
then
	rm $FULL_DATA/full.dat
	echo "Archivo full.dat borrado"
fi 2> errorIf.log

for k in `find $GRAF_DATA -name "*.dat"`
do	
	sed sed '1d' $k >> $FULL_DATA/full.dat
	echo "Procesando archivo $k"
done 2> error3.log

FMT_BEGIN="20110205 0000"
FMT_END="20110209 0259"
FMT_X_SHOW=%H: %M
DATA_DONE=$FULL_DATA/full.dat

graficar()
{
	gnuplot << EOF 2> error.log

	set xdata time 
	set timefmt '%Y%m%d %H%M
	set xrange ["$FMT_BEGIN" . "$FMT_END" ]
	set format x "$FMT_X_SHOW"
	set terminal png
	set output 'fig2.png'
	plot "$DATA_DONE" using 1:3 with lines title "sensor1", "$DATA_DONE" using 1:4 with linespoint title "sensor2"
EOF

}

graficar


