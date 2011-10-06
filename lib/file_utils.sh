#!/bin/sh
########################################################################
# Diskspace Usage Test
# Description: Verifies diskspace used is below a specified threshold.
#
########################################################################

function set_input_file(){ # $1 = file name
   if [ -f "$1" ]; then
     echo "$1"
   else
     throw_error  "File: $1 does not exits" "$test_output_file"
   fi
}

function is_directory(){ # $1 = string to check
   search_string="[a-zA-Z0-9]/$"
   #search_string="[[:alnum:]]/$"
   if `echo ${1} | grep "${search_string}" 1>/dev/null 2>&1` ; then
      echo "true"
   else
      echo "false"
   fi
}

#Usage is_directory() $1 = string to check
#this_string="/dir/dir/"
#if [[ $(is_directory $this_String) == "true" ]] ; then
#echo "success!"
#fi

#Usage set_input_file() $1 = file name
#set_input_file "my_File"
