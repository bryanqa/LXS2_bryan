#!/bin/bash

#### Primero revisamos que el numero de parametros sea el correcto"
#-------------------------------------------------
#Revision de argumentos

#Son tres argumentos
ARGS=3

if [ $# -ne $ARGS ]
then 
	echo "Error:"
	echo "Uso: $0 <op1> <op2> <op3>"
	exit 1
fi

#-------------------------------------------------


#Quiero ver cuales fueron los argumentos

