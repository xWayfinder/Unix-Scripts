#!/bin/sh
########################################################################
# OS Utils
# Description: Collection of useful Operating System functions.
#
########################################################################

function is_solaris(){
if [ -n "uname | grep "SunOS"" ]; then
   echo "false"
else
   echo "true"
fi
}

#Usage
#is_solaris
