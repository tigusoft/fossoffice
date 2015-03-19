#!/bin/bash

log=~/ssh.log
logdate=$(date) ; echo "[$logdate] Starting the ssh loops." >> $log

nohup ./loop_connection1.sh &
nohup ./loop_connection2.sh &


