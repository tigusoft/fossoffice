#!/bin/bash

cfgfile="conf-srv2.local.sh"
source $cfgfile || { echo "ERROR can not load configuration from $cfgfile" ; exit 1 ; } 

while true
do
	sleep "$revssh_delay_before"
        ./sshcli_connection.sh "$revssh_user" "$revssh_host" "$revssh_ssh_port" "$revssh_my_port"
	sleep "$revssh_delay_after"
done

