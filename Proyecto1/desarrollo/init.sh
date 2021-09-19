#Verificación
if ! command -v tc &> /dev/null 
then
    echo 'no está el comando tc'
    exit
fi
if ! command -v iptables &> /dev/null 
then
    echo 'no está el comando iptables'
    exit
fi
if ! command -v crontab &> /dev/null
then
    echo 'no está el comando contrab'
    exit
fi

#Eliminar toda conexión de iptables de fabrica
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

#direcciones mac de clientes
i=0
while read -r linea
do 
    if [ $i -eq 0 ]; then MAC_1=${linea}; fi
    if [ $i -eq 1 ]; then MAC_2=${linea}; fi
    if [ $i -eq 2 ]; then MAC_3=${linea}; fi
    i=$((i+1))
done < ../archivos/macsiniciales.conf

#Interfaz que debian comparte
INTERFAZ=enp0s8

insmod sch_htb 2> /dev/null

#nodo raíz
tc qdisc add dev $INTERFAZ root handle 1: htb default 0xA 

arreglo_mac() {
    #split mac
    readarray -d : -t PARTES <<< $1 
    P1=${PARTES[0]}${PARTES[1]}
    P2=${PARTES[2]}${PARTES[3]}
    P3=${PARTES[4]}${PARTES[5]}

#asignar mac **.**.**.**.**.**
    #si es origen
    tc filter add dev $INTERFAZ parent 1: protocol ip prio 5 u32 match u16 0x0800 0xFFFF at -2 match u16 0x${P3} 0xFFFF at -4 match u32 0x${P1}${P2} 0xFFFFFFFF at -8 flowid $2 
    #$TCF match u16 0x${P3} 0xFFFF at -4 match u32 0x${P1}${P2} 0xFFFFFFFF at -8 flowid $2
    #si es destino
    tc filter add dev $INTERFAZ parent 1: protocol ip prio 5 u32 match u16 0x0800 0xFFFF at -2 match u32 0x${P2}${P3} 0xFFFFFFFF at -12 match u16 0x${P1} 0xFFFF at -14 flowid $2
    #$TCF match u32 0x${P2}${P3} 0xFFFFFFFF at -12 match u16 0x${P1} 0xFFFF at -14 flowid $2 
}


#Creamos los nodos hijos, que serían 3 usuarios (los usuarios centos)

tc class add dev $INTERFAZ parent 1:1 classid 1:101 htb rate 1Kbit
tc class add dev $INTERFAZ parent 1:1 classid 1:102 htb rate 1Kbit
tc class add dev $INTERFAZ parent 1:1 classid 1:103 htb rate 1Kbit


arreglo_mac $MAC_1 1:101
arreglo_mac $MAC_2 1:102
arreglo_mac $MAC_3 1:103

echo ""
echo "Saliendo de pagina init"
echo ""