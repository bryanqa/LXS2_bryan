#!/bin/bash




# La salida estandar de error estara redireccionada al archivo if-then-sh-.err

if cp archivo1.txt archivo.txt.bck 2> $0.err
then	


	echo "El archivo1.txt fue correctamente respaldado" 
fi
