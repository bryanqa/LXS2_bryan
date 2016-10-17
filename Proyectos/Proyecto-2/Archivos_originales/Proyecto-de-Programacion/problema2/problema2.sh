#!/bin/bash

DATA=./hojasDatos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=./plot
FULL_DATA=$DATA/full_datos
mkdir $DATA/datos_csv
mkdir plot
mkdir $FULL_DATA
m=0

for i in `find $DATA -name "*.xls" | sort -n`

do
        echo "Procesando archivo $i"

        xls2csv $i > $OUT_DATA/data-0$m.csv
        let m=m+1
done 2> error1.log

for e in `find $OUT_DATA -name "*00.csv"`
do
        echo "Dando formato de datos para graficar Luz Enero"
	cat $e | awk -F "\",\"" 'FNR == 4 {print "012016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Luz/#Luz/g' > $GRAF_DATA/graf-luz.dat
		

done 2> error2.log

for e in `find $OUT_DATA -name "*01.csv"`
do
        echo "Dando formato de datos para graficar Luz Febrero"
	cat $e | awk -F "\",\"" 'FNR == 4 {print "022016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Luz/#Luz/g' >> $GRAF_DATA/graf-luz.dat

done 2> error3.log
		

for e in `find $OUT_DATA -name "*02.csv"`
do
        echo "Dando formato de datos para graficar Luz Marzo"
	cat $e | awk -F "\",\"" 'FNR == 4 {print "032016" " " $2 " " $1 " " }' |sed '1,$ s/"//g' | sed '1,$ s/Luz/#Luz/g' >> $GRAF_DATA/graf-luz.dat
		

done 2> error4.log

FMT_BEGIN="012016"
FMT_END="062016"
FMT_X_SHOW="%m:%Y"
DATA_DONE=$GRAF_DATA/graf-luz.dat

graficar()
{
        gnuplot << EOF 2> error.log

        set xdata time 
        set timefmt '%m%Y'
        set xrange ["$FMT_BEGIN" : "$FMT_END" ]
        set format x $FMT_X_SHOW
        set terminal png
        set output 'graf.png'
        plot "./plot/graf-luz.dat" using 1:2 with lines title "Luz"
EOF

}

graficar





