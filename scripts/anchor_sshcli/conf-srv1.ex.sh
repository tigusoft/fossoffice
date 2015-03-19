
# Configure here your revssh ssh server access. Copy this file first to file conf-srv1.local.sh and same for -srv2 etc.

revssh_user="ssh_user_to_ssh_into"
revssh_host="some-server-ip-or-hostname.org"
revssh_ssh_port="22" # ssh port of revssh 
revssh_my_port="29001" # on this port this client will listen on the remote revssh server
revssh_delay_before=60 # delay before (re) connecting
revssh_delay_after=100 # delay after connection (e.g. before reconnecting)

