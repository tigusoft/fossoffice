# Configure here your revssh ssh server access. Copy this file first to file conf-srv1.local.sh and same for -srv2 etc.

revssh_srv_host="84.x.x.x"
revssh_srv_user="revssh_FOOBAR_1"
revssh_srv_port="1001"

revssh_my_port_remote="29011" # on this port the client will listen on the remote server
revssh_my_port_here="1022" # this is the port of local ssh server

revssh_delay_before=90 # delay before (re) connecting
revssh_delay_after=40 # delay after connection (e.g. before reconnecting)

