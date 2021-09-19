#eliminar iptables
iptables -F 

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#eliminar los ancho de banda
tc qdisc del dev enp0s8 root

#eliminar todos los atq
while read -a l
do
    atrm ${l[0]}
done <<< $(atq)

#eliminar los atq programados por día en el archivo
cat /dev/null > /home/marito/Documentos/Proyecto1_Redes2/Proyecto1/reglas/reglas.sh