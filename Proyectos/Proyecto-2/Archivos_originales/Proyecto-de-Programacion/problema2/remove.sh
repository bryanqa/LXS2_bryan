#!/bin/bash


rm -rf ./hojasDatos/datos_csv
rm -rf ./plot


for i in `find -name "*.log" -or -name  "*.png"`

do 

	rm $i
	


done 1> errortest



