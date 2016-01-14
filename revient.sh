#!/bin/bash

# Para usar, el primer agumento es "nombre_de_usuario" <-- los espacios se reflejan con _ (barra baja),
# y el segundo argumento es el archivo que queremos enviar
#como tercer argumento se le puede pasar un archivo log.txt ue indica la linea a partir de la cual enviar el archivo

if [[ $# == 2 ]]; then
  (sleep 1; echo "contact_list"; sleep 1;
    while IFS='' read -r line || [[ -n "$line" ]]; do
       echo "msg $1 $line"
       echo "$((linea++)) to $1" > log.txt
       sleep 1
    done < "$2";) | /home/rafa/tg/bin/telegram-cli -W -v -k /home/rafa/tg/tg-server.pub
elif [[ $# == 3 ]]; then
  linea=$(cat log.txt | cut -d ' ' -f 1)
  echo $linea
  i=0
  (sleep 1; echo "contact_list"; sleep 1;
    while IFS='' read -r line || [[ -n "$line" ]]; do
      if [[ $i -lt $linea ]]; then
          i=$((i+1))
      elif [[ $i -ge $linea ]]; then
        echo "msg $1 $line"
        echo "$((linea++)) to $1" > log.txt
        sleep 1
      fi
    done < "$2";) | ~/tg/bin/telegram-cli -W -v -k ~/tg/tg-server.pub
fi
