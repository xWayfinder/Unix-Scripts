#!/bin/sh
########################################################################
# Network Utils
# Description: Collection of useful Networking functions.
#
########################################################################

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

#this funciton needs to be revised to work on solaris also
function check_port_state(){ # $1=port_number $2=port_state
      #reg_ex="^ [0-9] $1[a-zA-Z0-9._-/:]
      reg_ex="[[:space:][:alnum:][:graph:]]*$1[[:space:][:alnum:][:graph:]]*$2"
      netstat -tan | grep "$reg_ex"
}

#Usage get_port_state() $1 = port_number
#get_port_state "8080"

#Usage check_port_state() $1=port_number $2=port_state
#check_port_state "8080" "LISTENING"
