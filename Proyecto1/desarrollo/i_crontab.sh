#$1 minuto
#$2 hora
#$3 ancho de banda
#$4 CADENA
#$5 dirección mac

INTERFAZ=enp0s8
#direcciones mac de clientes
i=0
while read -r l
do 
    if [ $i -eq 0 ]; then MAC_1=${l}; fi
    if [ $i -eq 1 ]; then MAC_2=${l}; fi
    if [ $i -eq 2 ]; then MAC_3=${l}; fi
    i=$((i+1))
done < ../archivos/macsiniciales.conf

if [ $4==$MAC_1 ]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:101 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
if [ $4==$MAC_2 ]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:102 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
if [ $4==$MAC_3 ]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFAZ parent 1:1 classid 1:103 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
