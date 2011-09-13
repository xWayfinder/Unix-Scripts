#!/bin/sh


function set_input_file(){
   if [ -f "$1" ]; then
     echo "$1"
   else
     throw_error  "File: $1 does not exits" "$test_output_file"
   fi
}

function is_directory(){
   search_string="[[:alnum:]]/$"
   if `echo ${1} | grep "${search_string}" 1>/dev/null 2>&1` ; then
      echo "true"
   else
      echo "false"
   fi
}


#####################
#TEST - is_directory
######################
#this_string="/dir/dir/"
#if [[ $(is_directory $this_String) == "true" ]] ; then
#echo "success!"
#fi
