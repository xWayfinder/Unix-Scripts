#!/bin/sh
########################################################################
# Port Listening Test
# Description: Verifies expected ports are listening.
#
########################################################################
lib_dir="../lib"
source "$lib_dir/system_resource_utils.sh"

#memory test might take 5 samples over a few seconds and give the average then
#verify that it's not below a certain threshold

#get_free_memory
