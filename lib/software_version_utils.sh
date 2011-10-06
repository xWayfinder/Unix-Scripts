#!/bin/sh
########################################################################
# Software Version Utils
# Description: Collection of useful Software Version functions.
#
########################################################################

function verify_java_version(){ # $1 = verison
out=$( { java -version; } 2>&1 )
ver=`echo $out | sed 's/java version "\([0-9][0-9._]*\)".*/\1/'`
if [ "$ver" == "$1" ]; then
   echo "true"
else
   echo "false"
fi
}

#USAGE: 
verify_java_version $1
