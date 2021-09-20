#update a debian
apt-get update

#reiniciamos todas las configuraciones iniciales de iptables
iptables -F


# Configurar con nmtui:
#### red extra a la de internet
#### le damos a editar
#### colocamos el ipv4 en manual
#### agregar la dirección ip 120.120.120.1/24

# Ingresamos a la carpeta /etc/sysctl.conf
#### descomentamos la linea de:
    ### net.ipv4_ip_forward=1


#agregamos la mascara de red
firewall-cmd --add-masquerade --permanent


#instalamos la herramienta at
apt-get install at