#update a centos
yum update

#reiniciamos todas las configuraciones de iptables
iptables -F

## Configurar con nmtui:
#### nos dirigimos a la red,
#### editar red
#### ipv4 manual
#### agregar la dirección ip 120.120.120.2/24
#### agregar el punto de enlace 120.120.120.1
#### agregar dns 8.8.8.8


#instalamos epel-release, que nos ayudará para las dependencias de otras herramientas
yum install -y epel-release

#instalamos la herramienta de speedtest
yum install -y speedtest-cli

#instalamos la herramienta de netcat
yum install -y netcat