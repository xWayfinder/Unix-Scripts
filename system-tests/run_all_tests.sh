#!/bin/sh
########################################################################
# Run All Tests
# Description: Sets up test propertties and runs all systems test.
# 
# TODO: This script needs to be configuarble for different environments
#       so that there can be multiple environment.config the script will
#       know what server it's on and use the correct script
#
########################################################################
########
#BEFORE#
########
if [ -n $1 ]; then
output_dir="/home/developer/tests/"
else
output_dir="$1"
fi

#######
#TESTS#
#######
#VERIFY: correct Proccesses are running
#echo `bash process_test.sh "processes" $output_dir`

#TODO VERIFY: correct Ports are listening
#echo `bash port_listening_test.sh "ports" $output_dir`
   #what about open ports

#VERIFY: Diskspace Usage under threshold 
echo `bash diskspace_usage_test.sh "diskspace_dir_threshold" $output_dir`

#TODO VERIFY: Memory Usage under threshold
#echo `bash memory_usage_test.sh "memory_threshold" $output_dir`

#TODO VERIFY: correct Software Versions installed  
#echo `bash software_version_test.sh $output_dir`

#TODO VERIFY: correct Locale

#TODO VERIFY: connectivity between App and DB servers

#TODO VERIFY: external connectivity to Application (telnet) with no errors in header 

#TODO VERIFY: logs don't contain errors	

#TODO VERIFY: bug test eg weblogic memory allocations
