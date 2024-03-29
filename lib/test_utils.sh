#!/bin/sh
########################################################################
# Test Utils
# Description: Collection of useful function for writing and tests.
#
########################################################################
source "$lib_dir/string_utils.sh"
source "$lib_dir/file_utils.sh"

function throw_error(){ #$1=error_message $2=error_log
   echo "FAILED" >> "$2"
   echo "ERROR: $1" >> "$2"
   exit 2                    
}

function timestamp_logfile(){ #$1=filename
   timestamp=$(date|sed 's/ /_/g')
   timestamp=$(echo $timestamp|sed 's/:/_/g')
   echo "$1_$timestamp.log"
}

function format_result(){ #$1=result $2=logfile
    echo "$1: for more details see the file $2"
}

function set_test_output_file(){ #$@ 
   if [ $# -eq 2 ]; then
      if [[ $(is_directory $2) == "true" ]] ; then
         mkdir -p $2
         file_name="$2$(timestamp_logfile "$(replace $0 ".sh" "")")"
      else
         file_name="$2"
      fi
   else
      file_name=$(timestamp_logfile "$(replace $0 ".sh" "")")
   fi
   echo "Run: `date`" > "$file_name"
   echo "$file_name"
}
