#!/bin/bash

cfgfile="conf-srv2.local.sh"
source $cfgfile || { echo "ERROR can not load configuration from $cfgfile" ; exit 1 ; } 

while true
do
	sleep "$revssh_delay_before"
        ./sshcli_connection.sh "$cfgfile"
	sleep "$revssh_delay_after"
done

