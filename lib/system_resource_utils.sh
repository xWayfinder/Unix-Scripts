#!/bin/sh
########################################################################
# System Resources Utils
# Description: Collection of useful system resource functions.
#
########################################################################
source "$lib_dir/os_utils.sh"

function get_disk_usage(){ # $1 = directory name to check 
dir=$1
usage=`df -P $dir | sed '2 s/.* \([0-9]*%\).*/\1/'| grep "[0-9][0-9]*%"`
echo $usage
#Return -1 for case if directory doesn't exist.
}

function is_diskspace_usage_below_threshold(){ # $1 = threshold $2 = actual_usage
threshold=$1
actual_usage=$2
#Validate actual_usage is 0 or above
#Below 0 means directory doesn't exist\
if [ $actual_usage -lt 0 ] ; then
   echo "not_exist"
fi
#Validate threshold is 100 ro below
if [ $threshold -gt 100 || $threshold -lt 0 ] : then
   echo "invalid_threshold"
fi
#Return comparison of above or below for actual and threshold
if [ $threshold -lt $actual_usage ] ; then
}

function get_free_memory(){
case "$(is_solaris)" in
         "true") #Solaris
           vmstat | grep "[^a-z][0-9][0-9]*" | sed 's/^[ ][0-9][ ][0-9][ ][0-9][ ][0-9]*[ ]\([0-9][0-9]* \).*/\1/' ;;
         "false") #Linux
            vmstat | grep "[^a-z][0-9][0-9]*" | sed 's/^[ ]\([0-9][ ]\+\)\{2,3\}[0-9]\+[ ]\+\([0-9][0-9]*\).*/\2/' ;;
esac
}

#Usage function get_free_memory()
#get_free_memory

#Usage function get_disk_usage()
#my_res=$(get_disk_usage '/')
#echo "The disk has $my_res usage"
