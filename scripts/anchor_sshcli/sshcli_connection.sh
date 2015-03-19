#!/bin/bash
# rfree@mempo.org; create and timeoutkill ssh tunnel to us via ssh -R

# debugging:
# see below for tee
# uncomment set -x to see commands
# start directly in foreground
# FAQ: see install.txt

log=~/ssh.log

cfgfile="$1"
source "$cfgfile" || { echo "Can not open configuration file cfgfile=$cfgfile"; sleep 10 ; exit 1; }

#
# ssh -v revssh_lp2@84.10.39.162 -p 1001  -R localhost:29011:localhost:1022
#
#revssh_srv_host="84.10.39.162"
#revssh_srv_user="revssh_lp2"
#revssh_srv_port="1001"
#
#revssh_my_port_remote="29011" # on this port the client will listen on the remote server
#revssh_my_port_here="1022" # this is the port of local ssh server
#

revssh_testconnection_port_here=$revssh_my_port_remote # port here to which we will send PING to go out and return via remote listening port on remote server and be echoed by our sshd

tout1=40 # main timeout in seconds for network/ssh before killing
tout2=10 # ping timeout
tout2b=$((tout2 + 3)) # slightly longer timeout (e.g. before -9 KILL)
tout3=10 # this is how long to wait after connecting e.g. before creating test tunnel
ping_sleep=30 # sleep between pings

function _log_raw() {
	logdate=$(date) 
	# echo "[$logdate]" "$@" | tee -a "$log" # DEBUG debug - more debug (also to screen)
	echo "[$logdate]" "$@" >> "$log"
}
function _info() { 
	:
	_log_raw "[info]" "$@" 
}
function _dbg1() { 
	:
	_log_raw "[dbg1]" "$@" ; 
}

_info "Will connect to $user1 $host1 $port1 to create server there on $port2"
#set -x

# main tunnel, like ssh -v revssh_lp2@84.10.39.162 -p 1001  -R localhost:29011:localhost:1022 ...
ssh -v $revssh_srv_user@"$revssh_srv_host"  -p $revssh_srv_port  -N -T -R *:"$revssh_my_port_remote":localhost:"$revssh_my_port_here" \
	-oServerAliveInterval=$tout1 -oServerAliveCountMax=2 -oBatchMode=yes -oConnectTimeout=$tout1  &
pid_ssh="$!" # pid of the ssh is in background
set +x
_dbg1 "Main ssh on pid $pid_ssh"

sleep $tout3

_dbg1 "Creating test tunnel"
# set -x
# create a tunnel to test the remote endpoint from the remote server
ssh -v $revssh_srv_user@"$revssh_srv_host"  -p $revssh_srv_port  -N -T  -L localhost:"$revssh_testconnection_port_here":localhost:"$revssh_my_port_remote" \
	-oServerAliveInterval=$tout1 -oServerAliveCountMax=2 -oBatchMode=yes -oConnectTimeout=$tout1  &
pid_sshtest="$!" # pid of the ssh to test main tunnel
_dbg1 "Test ssh on pid $pid_ssh"

sleep $tout3

_info "Fully started ssh to $host1 $port2 on pid: $pid_ssh $pid_sshtest"

while true
do
	sleep $ping_sleep
	_dbg1 "Ping is being sent"
#set -x
	ping_reply=$(timeout --kill-after=$tout2b $tout2 ssh -T -oConnectTimeout=$tout2 localhost -p "$revssh_testconnection_port_here" echo TUNNEL_PING_OK)
	ping_exit="$?"
set +x
	_dbg1 "Ping exit=$ping_exit reply=$ping_reply"
	# exit if ping failed:
	[[ "$ping_exit" == "0" ]] || { echo "BAD PING" ; echo "bad ping exit $ping_exit" ;  }
	[[ "$ping_reply" == "TUNNEL_PING_OK" ]] || { echo "BAD PING" ; echo "bad ping reply $ping_reply" ;  }
	# or if main ssh or the test-tunnel ssh died:
	kill -0 $pid_ssh || { echo "no pid" ; break ; }
	kill -0 $pid_sshtest || { echo "no pid test" ; break ; }
	_dbg1 "Ping seems ok"
done

kill "$pid_ssh" &
kill "$pid_sshtest" &
sleep 1
kill -9 "$pid_ssh"
kill -9 "$pid_sshtest"

_info "Ended ssh to $host1 $port2 on pid_ssh=$pid_ssh"


