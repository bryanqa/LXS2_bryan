#!/bin/bash


sh ./remove.sh
DATA=./hojasDatos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=./plot
mkdir $DATA/datos_csv
mkdir $GRAF_DATA
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

for e in `find $OUT_DATA -name "*00.csv"`
do
        echo "Dando formato de datos para graficar Luz Enero"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "012016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' > $GRAF_DATA/graf-agua.dat
		

done 2> error5.log

for e in `find $OUT_DATA -name "*01.csv"`
do
        echo "Dando formato de datos para graficar Luz Febrero"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "022016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' >> $GRAF_DATA/graf-agua.dat

done 2> error6.log

for e in `find $OUT_DATA -name "*02.csv"`
do
        echo "Dando formato de datos para graficar Luz Marzo"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "032016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' >> $GRAF_DATA/graf-agua.dat


done 2> error7.log

for e in `find $OUT_DATA -name "*03.csv"`
do
        echo "Dando formato de datos para graficar Luz Abril"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "042016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' >> $GRAF_DATA/graf-agua.dat


done 2> error8.log

for e in `find $OUT_DATA -name "*04.csv"`
do
        echo "Dando formato de datos para graficar Luz Mayo"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "052016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' >> $GRAF_DATA/graf-agua.dat



done 2> error9.log

for e in `find $OUT_DATA -name "*05.csv"`
do
        echo "Dando formato de datos para graficar Luz Junio"
	cat $e | awk -F "\",\"" 'FNR == 3 {print "062016" " " $2 " " $1 " " }' |sed '1,$ s/"//g'| sed '1,$ s/Agua/#Agua/g' >> $GRAF_DATA/graf-agua.dat

done 2> error10.log


graficar()
{
        gnuplot << EOF 2> error.log


 	set xdata time 
        set timefmt '%m'
        set xrange ["012016" : "062016" ]
        set format x '%m'
        set terminal png
	set title "Grafico de Luz y Agua 2016"
	set ylabel "Colones"
        set output 'graf.png'
	plot "./plot/graf-agua.dat" using 1:2 with linespoint title "Agua", \
	     "./plot/graf-luz.dat" using 1:2 with linespoint title "Luz"



EOF

}

graficar





