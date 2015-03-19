#!/bin/bash

log=~/ssh.log



mydir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$mydir"


logdate=$(date) ; echo "[$logdate] Starting the ssh loops (in pwd=$PWD from mydir=$mydir)." >> $log

nohup ./loop_connection1.sh &
nohup ./loop_connection2.sh &


