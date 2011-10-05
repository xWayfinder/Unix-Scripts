#!/bin/sh
########################################################################
# String Utils
# Description: Collection of string manipulation functions 
#
########################################################################

function replace(){ # $1=orignal_string, $2=find, $3=replace
 echo $1 | sed -e "s/$2/$3/g"
}
#Usage function replace(){  $1=orignal_string $2=find $3=replace
#replace "abcd1234" "1234" "4321"
