#!/bin/bash

# Para usar, el primer agumento es "nombre_de_usuario" <-- los espacios se reflejan con _ (barra baja),
# y el segundo argumento es el archivo que queremos enviar
# como tercer argumento se le puede pasar un número que indica la linea a partir de la cual enviar el archivo
if [[ $1 == '--help' ]]; then
  echo "Uso: ./revient.sh <peer> <file>\n"
  echo "Uso: ./revient.sh <peer> <file> log.txt"
  echo "Uso: ./revient.sh --help muestra este mensaje"
elif [[ $# == 0 ]]; then
  echo "muy pocos parametros"
  echo "Uso: ./revient.sh <peer> <file>\n"
  echo "Uso: ./revient.sh <peer> <file> log.txt"
  echo "Uso: ./revient.sh --help muestra este mensaje"
elif [[ $# == 3 ]]; then
	i=$( cat $3 | cut -d ' ' -f 1)
else
	i=0
fi

linea=0

(sleep 1; echo "contact_list"; sleep 1;
while IFS='' read -r line || [[ -n "$line" ]]; do
   ((linea++));
   if [[ $linea -lt $i ]]; then continue; fi

   echo "msg $1 $line"
   echo "$linea to $1" > log.txt

   sleep 1
done < "$2";) | ~/tg/bin/telegram-cli -W -v -k ~/tg/tg-server.pub
