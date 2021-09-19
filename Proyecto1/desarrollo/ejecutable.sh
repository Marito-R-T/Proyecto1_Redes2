#ejecutar y empezar con las lecturas

echo 'Archivo de enlace'
while read -r l
do
    readarray -d = -t ENLACE <<< $l
    #ANCHO DE BAJADA
    if [ ${ENLACE[0]} = 'down' ]; then ANCHOB=${ENLACE[1]}; fi
    #ANCHO DE SUBIDA
    if [ ${ENLACE[0]} = 'up' ]; then ANCHOS=${ENLACE[1]}; fi
done < ../archivos/enlace.conf
ANCHO=$(((ANCHOB+ANCHOS)*1024))
echo "El ancho de banda es de: ${ANCHO}Kbit"
echo
echo

echo 'Archivo de modo'
while read -r l
do
    readarray -d = -t MODO <<< $l
    MODOF=${MODO[1]}
done < ../archivos/modo.conf
echo "El modo de configuración es ${MODOF}"
echo
echo

if [ $MODOF -eq 2 ]; then CADENA="ceil ${ANCHO}Kbit"; fi
echo 'Archivo de usuario_BW'
while read -r l 
do
    readarray -d , -t USUARIOBW <<< $l
    #ancho de bajada
    AB=${USUARIOBW[1]}
    #ancho de subida
    AS=${USUARIOBW[2]}
    BWT=$((ANCHO*(AB+AS)/100))
    readarray -d : -t H_INICIO <<< ${USUARIOBW[3]}
    readarray -d : -t H_FIN <<< ${USUARIOBW[4]}
    bash i_crontab.sh ${H_INICIO[1]} ${H_INICIO[0]} $BWT $CADENA ${USUARIOBW[0]} 
    bash i_crontab.sh ${H_FIN[1]} ${H_FIN[0]} 1 $CADENA ${USUARIOBW[0]}
done < ../archivos/usuario_BW.conf
echo
echo

echo 'Archivo de usuario-PROTO'
while read -r l
do
    readarray -d , -t USUARIOPROTO <<< $l
    if [ ${#USUARIOPROTO[@]} -eq 4 ]; then #parametros: mac,protocolo,horainicio,horafin
      bash i_command.sh 0 icmp ${USUARIOPROTO[0]} ${USUARIOPROTO[2]} ${USUARIOPROTO[3]}
    fi

    if [ ${#USUARIOPROTO[@]} -eq 5 ]; then #parametros: mac,protocolo,puerto(s),horainicio,horafin
      readarray -d : -t PUERTOS <<< "${parametros[2]}"
      if [ ${#PUERTOS[@]} -eq 2 ]; then
        bash i_command.sh 1 ${USUARIOPROTO[1]} ${USUARIOPROTO[0]} ${USUARIOPROTO[3]} ${USUARIOPROTO[4]} ${PUERTOS[0]} ${PUERTOS[1]}
      else 
        bash i_command.sh 2 ${USUARIOPROTO[1]} ${USUARIOPROTO[0]} ${USUARIOPROTO[3]} ${USUARIOPROTO[4]} ${USUARIOPROTO[2]}
      fi
    fi
done < ../archivos/usuario_PROTO.conf
echo
