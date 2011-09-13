#!/bin/sh
lib_dir="../../lib"
source "$lib_dir/network_utils.sh"
source "$lib_dir/test_utils.sh"
source "$lib_dir/file_utils.sh"

function run_test(){
   test_output_file=$(set_test_output_file $@)
   validate_args $@
   test_input_file=$(set_input_file $1)
   verify_all_ports_are_listening
   echo "$(record_test_results)"
}

function validate_args(){ # $@ pass all fields in
   if [ $# -lt 1 ] || [ $# -gt 2 ] ; then                
   throw_error "Usage $0 <port_input_file> [<test_output_file>]" "$test_output_file"
   fi
}

function verify_all_ports_are_listening(){
while read line
   do
      port_number=`echo $line| cut -d "," -f1 | tr -d " "`
      case $(get_port_state "$port_number") in
         "listening")
            listening="$port_number \n$listening";;
         "not_listening")
            not_listening="$port_number \n$not_listening";;
         "not_exist")
            not_exist="$port_number \n$not_exist";;
      esac
   done < "$test_input_file"
}


function record_test_results(){

   if [ -n "$not_listening" ] || [ -n "$not_exist" ]; then
      result="FAILED"
      echo $result >> "$test_output_file"

      if [ -n "$not_listening" ]; then
         echo "The following ports are NOT LISTENING" >> "$test_output_file"
         echo -e "$not_listening" >> "$test_output_file"
      fi
      if [ -n "$not_exist" ]; then
         echo "The following ports don't EXIST" >> "$test_output_file"
         echo -e "$not_exist" >> "$test_output_file"
      fi
   elif [ -n "$listening" ] && [ -z "$not_listening" ] && [ -z "$not_exist" ]; then
      result="PASSED"
      echo $result >> "$test_output_file"
   else
      result="ERROR"
   fi

   if [ -n "$listening" ] ; then
      echo "The following ports are LISTENING" >> "$test_output_file"
      echo -e $listening >> "$test_output_file"
   fi

   echo "$(format_result $result $test_output_file)"
}

run_test $@
