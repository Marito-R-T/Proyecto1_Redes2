#$1 hora:minuto
#$2 ancho de banda
#$3 dirección mac
#$4 CADENA

INTERFAZ=enp0s8
#direcciones mac de clientes
echo $4
i=0
while read -r l
do 
    if [ $i -eq 0 ]; then MAC_1=${l}; fi
    if [ $i -eq 1 ]; then MAC_2=${l}; fi
    if [ $i -eq 2 ]; then MAC_3=${l}; fi
    i=$((i+1))
done < ../archivos/macsiniciales.conf

if [ $3 == $MAC_1 ]; then
    echo $MAC_1
    echo "echo '/sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:101 htb rate ${2}Kbit $4' | at $1" >> /home/marito/Documentos/reglas/reglas.sh
elif [ $3 == $MAC_2 ]; then
    echo $MAC_2
    echo "echo '/sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:102 htb rate ${2}Kbit $4' | at $1" >> /home/marito/Documentos/reglas/reglas.sh
elif [ $3 == $MAC_3 ]; then
    echo $MAC_3
    echo "echo '/sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:103 htb rate ${2}Kbit $4' | at $1" >> /home/marito/Documentos/reglas/reglas.sh
fi
echo 
