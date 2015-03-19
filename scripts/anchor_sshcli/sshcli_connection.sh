#!/bin/bash
# rfree@mempo.org; create and timeoutkill ssh tunnel to us via ssh -R

log=~/ssh.log

user1="$1" # remote user on rdv server
host1="$2" # remote of rdv server
port1="$3" # ssh port on which the rdv server listens for rdv-clients like us

port2="$4" # port on which rdv server will listen on our behalf for people who want to connect actually into us

tout1=40 # main timeout in seconds for network/ssh before killing
tout2=5 # ping timeout
tout2b=$((tout2 + 3)) # slightly longer timeout (e.g. before -9 KILL)
tout3=25 # this is how long to wait after connecting e.g. before creating test tunnel
ping_sleep=20 # sleep between pings

function _log_raw() {
	logdate=$(date) 
	echo "[$logdate] " "$@" >> "$log" 
	# | tee -a "$log"
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

# main tunnel:
ssh revssh_lp1@"$host1" -N -T -R *:"$port2":localhost:"$port1" \
	-oServerAliveInterval=$tout1 -oServerAliveCountMax=2 -oBatchMode=yes -oConnectTimeout=$tout1  &
pid_ssh="$!" # pid of the ssh is in background
_dbg1 "Main ssh on pid $pid_ssh"

sleep $tout3

# create a tunnel to test the remote endpoint from the remote server
ssh revssh_lp1@"$host1" -N -T  -L localhost:"$port2":localhost:"$port2" \
	-oServerAliveInterval=$tout1 -oServerAliveCountMax=2 -oBatchMode=yes -oConnectTimeout=$tout1  &
pid_sshtest="$!" # pid of the ssh to test main tunnel
_dbg1 "Test ssh on pid $pid_ssh"

sleep $tout3

_info "Fully started ssh to $host1 $port2 on pid: $pid_ssh $pid_sshtest"

while true
do
	sleep $ping_sleep
	_dbg1 "Ping is being sent"
	ping_reply=$(timeout --kill-after=$tout2b $tout2 ssh -T -oConnectTimeout=$tout2 127.0.0.1 -p "$port2" echo TUNNEL_PING_OK)
	ping_exit="$?"
	_dbg1 "Ping exit=$ping_exit reply=$ping_reply"
	# exit if ping failed:
	[[ "$ping_exit" == "0" ]] || { echo "bad ping exit $ping_exit" ; break ; }
	[[ "$ping_reply" == "TUNNEL_PING_OK" ]] || { echo "bad ping reply $ping_reply" ; break ; }
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


