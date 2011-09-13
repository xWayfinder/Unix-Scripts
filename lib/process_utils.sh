#!/bin/sh

########################################################################
# PASS
# R - runnable which means the process has done a context switch and has the # kernel.
# S - sleeping which means the process is waiting on I/O completion (blocked), a pipe, memory, etc.
# O - means the process is the one that currenlty has the cpu
# FAIL
# T - process has been stopped - sent a SIGSTOP usually with ctrl/z
# Z - zombie - a process that has a process image in memory but no context, ie., not swappable.
########################################################################

function get_state (){ # $1=process_name
   process_name="$1"
   ALIVE="[S|R|O]"
   DEAD="[Z|T]"
   if [ -n "$(check_state "$DEAD" "$process_name")" ]; then
      echo "dead"
   elif [ -n "$(check_state "$ALIVE" "$process_name")" ]; then
      echo "alive"
   else
      echo "not_exist"
   fi   
   return 0
}

function check_state(){ # $1=state $2=process_name
#      reg_ex="^[0-9] $1[[:space:][:alnum:][:graph:]]*$2$"
     reg_ex="^[ ]*[0-9] $1[a-zA-Z0-9._-/: ]* $2$"
      ps -el | grep "$reg_ex"
}

