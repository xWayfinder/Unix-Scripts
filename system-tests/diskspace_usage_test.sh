#!/bin/sh
########################################################################
# Diskspace Usage Test
# Description: Verifies diskspace used is below a specified threshold.
#
########################################################################

lib_dir="../lib"
source "$lib_dir/system_resource_utils.sh"
source "$lib_dir/file_utils.sh"
source "$lib_dir/test_utils.sh"

function run_test(){
   test_output_file=$(set_test_output_file $@) 
   validate_args $@
   test_input_file=$(set_input_file $1)
   verify_diskspace_usage_below_threshold
   echo "$(record_test_results)"
}

function validate_args(){
   if [ $# -lt 1 ] || [ $# -gt 2 ] ; then                
   throw_error "Usage $0 <diskspace_dir_threshold_input_file> [<test_output_file>]" "$test_output_file"
   fi
}

#TODO validate if threshold number below 100
function verify_diskspace_usage_below_threshold(){
   while read line
   do
      directory=`echo $line| cut -d "," -f1 | tr -d " "`
      threshold=`echo $line| cut -d "," -f1 | tr -d " "`
      actual =
      case $(get_state "$process_name") in
         "below")
            below="$directory is at $actual% below $threshold \n$below";;
         "above")
            above="$directory is at $actual% above or equal to $threshold  \n$above";;
         "not_exist")
            not_exist="$directory \n$not_exist";;
         "invalid_threshold")
            invalid_threshold="$directory has an invalid threshold $threshold  \n$invalid_threshold";;
      esac
   done < "$test_input_file"
}

#TODO
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
