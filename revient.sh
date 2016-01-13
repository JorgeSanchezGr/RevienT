#!/bin/bash

# Para usar, el primer agumento es "nombre_de_usuario" <-- los espacios se reflejan con _ (barra baja),
# y el segundo argumento es el archivo que queremos enviar

(sleep 1; echo "contact_list"; sleep 1;
  while IFS='' read -r line || [[ -n "$line" ]]; do
     echo "msg $1 $line"
     sleep 1
  done < "$2";) | ~/tg/bin/telegram-cli -W -v -k ~/tg/tg-server.pub
