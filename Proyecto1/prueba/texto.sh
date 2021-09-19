#!/bin/bash
#i=0
#while read -r linea
#do
#    if [ $linea = '20:20:20:20:20:20' ]; then MAC_1=${linea}; fi
#    if [ $i -eq 1 ]; then MAC_2=${linea}; fi
#    if [ $i -eq 2 ]; then MAC_3=${linea}; fi
#    i=$((i+1))
#done < t.txt
#echo $MAC_1
#echo $MAC_2
#echo $MAC_3
n='hola'
f='hola'
if [ $n==$f ]; then
    echo 'igual'
else
    echo 'vacio'
fi
