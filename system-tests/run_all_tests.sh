#!/bin/sh
########################################################################
# Run All Tests
# Description: Sets up test propertties and runs all systems test.
#
########################################################################

#output_dir="/home/developer/Documents/output/"
output_dir="$1"
#if dir doesn't exist create it though maybe this hould be handled else where 

#Verify correct Proccesses are running
echo `bash process_test.sh "processes" $output_dir`

#Verify correct Ports are listening
#echo `bash port_listening_test.sh "ports" $output_dir`

#Verify Diskspace Usage under threshhold 
#echo `bash diskspace_usage_test.sh "diskspace_dir_threshold" $output_dir`

#Verify Memory Usage under threshhold
#echo `bash memory_usage_test.sh "memory_threshold" $output_dir`

#Verify correct Software Versions installed  
#echo `bash software_version_test.sh $output_dir`
