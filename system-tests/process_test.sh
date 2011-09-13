#!/bin/sh
########################################################################
# Process Test
# Description: A test to check 
#
########################################################################

lib_dir="../lib"
source "$lib_dir/process_utils.sh"
source "$lib_dir/file_utils.sh"
source "$lib_dir/test_utils.sh"

#Use the -c on grep to get the count if we need to do verifications on multiple processes

function run_test(){
   test_output_file=$(set_test_output_file $@)
   validate_args $@
   test_input_file=$(set_input_file $1)
   verify_all_process_are_running
   echo "$(record_test_results)"
}


function validate_args(){
   if [ $# -lt 1 ] || [ $# -gt 2 ] ; then                
   throw_error "Usage $0 <process_input_file> [<test_output_file>]" "$test_output_file"
   fi
}

function verify_all_process_are_running(){
   while read line
   do
      process_name=`echo $line| cut -d "," -f1 | tr -d " "`
      case $(get_state "$process_name") in
         "alive")
            alive="$process_name \n$alive";;
         "dead")
            dead="$process_name \n$dead";;
         "not_exist")
            not_exist="$process_name \n$not_exist";;
      esac
   done < "$test_input_file"
}

function record_test_results(){
   if [ -n "$dead" ] || [ -n "$not_exist" ]; then
      result="FAILED"
      echo $result >> "$test_output_file"
      
      if [ -n "$dead" ]; then
         echo "The following processes are DEAD" >> "$test_output_file"
         echo -e "$dead" >> "$test_output_file"
      fi
      if [ -n "$not_exist" ]; then
         echo "The following processes don't EXIST" >> "$test_output_file"
         echo -e "$not_exist" >> "$test_output_file"
      fi
   elif [ -n "$alive" ] && [ -z "$dead" ] && [ -z "$not_exist" ]; then
      result="PASSED"
      echo $result >> "$test_output_file"
   else
      result="ERROR"
   fi

   if [ -n "$alive" ] ; then
      echo "The following processes are ALIVE" >> "$test_output_file"
      echo -e $alive >> "$test_output_file"
   fi

   echo "$(format_result $result $test_output_file)"
}

run_test $@
