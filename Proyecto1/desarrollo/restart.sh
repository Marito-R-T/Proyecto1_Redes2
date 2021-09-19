iptables -F 

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

tc qdisc del dev enp0s8 root

cat /dev/null > /home/marito/Documentos/Proyecto1_Redes2/Proyecto1/reglas/reglas.sh