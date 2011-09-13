#!/bin/sh

function replace(){ # $1=orignal_string, $2=find, $3=replace
 echo $1 | sed -e "s/$2/$3/g"
}
