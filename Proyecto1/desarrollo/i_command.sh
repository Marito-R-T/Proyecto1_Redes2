#$1 tipo 
#$2 PROTOCOLO
#$3 MAC
#$4 tiempo inicio
#$5 tiempo fin
#$6 puerto inicio
#$7 puerto fin

while read -r l
do
    if [ $3 == $l ]; then MAC=$l; fi
done < ../archivos/macsiniciales.conf

if [[ -n $MAC ]]; then
    if [ $1 -eq 0 ]; then
        iptables -I FORWARD 1 -p icmp -m mac --mac-source $MAC -m time --timestart $4 --timestop $5 -j ACCEPT
        iptables -I FORWARD 1 -p icmp -m state --state RELATED,ESTABLISHED -m time --timestart $4 --timestop $5 -j ACCEPT
    fi
    if [ $1 -eq 1 ]; then
        iptables -I FORWARD 1 -p $2 -m mac --mac-source $MAC -m $2 --dport $6:$7 -m time --timestart $4 --timestop $5 -j ACCEPT
        iptables -I FORWARD 1 -p $2 -m state --state RELATED,ESTABLISHED -m $2 --sport $6:$7 -m time --timestart $4 --timestop $5 -j ACCEPT
    fi
    if [ $1 -eq 2 ]; then
        iptables -I FORWARD 1 -p $2 -m mac --mac-source $MAC -m $2 --dport $6 -m time --timestart $4 --timestop $5 -j ACCEPT
        iptables -I FORWARD 1 -p $2 -m state --state RELATED,ESTABLISHED -m $2 --sport $6 -m time --timestart $4 --timestop $5 -j ACCEPT
    fi
fi