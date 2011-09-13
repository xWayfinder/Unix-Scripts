#!/bin/sh

function get_port_state(){ # $1=port_number
  port_number="$1"

   if [ -n "$(check_port_state "$port_number" 'LISTEN' )" ]; then
      echo "listening"
   elif [ -n "$(check_port_state "$port_number" '' )" ]; then
      echo "not_listening"
   else
      echo "not_exist"
   fi   
   return 0
}


function check_port_state(){ # $1=state $2=process_name
      reg_ex="[[:space:][:alnum:][:graph:]]*$1[[:space:][:alnum:][:graph:]]*$2"
      netstat -tan | grep "$reg_ex"
}
