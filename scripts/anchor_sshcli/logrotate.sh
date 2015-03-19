#!/bin/bash
cd ~

rm -f ssh.log.7
mv ssh.log.6 ssh.log.7 
mv ssh.log.5 ssh.log.6
mv ssh.log.4 ssh.log.5
mv ssh.log.3 ssh.log.4
mv ssh.log.2 ssh.log.3
mv ssh.log.1 ssh.log.2
mv ssh.log   ssh.log.1
logdate=$(date) ; echo "[$logdate] Rotated the logs" >> ~/ssh.log

rm -f nohup.out.1
mv nohup.out  nohup.out.1
touch nohup.out
logdate=$(date) ; echo "[$logdate] Rotated the logs (nohup.out - there can be several in various directories)" >> nohup.out

dir2="$HOME/anchor_sshcli/"
rm -f $dir2/nohup.out.1
mv $dir2/nohup.out  $dir2/nohup.out.1
touch $dir2/nohup.out
logdate=$(date) ; echo "[$logdate] Rotated the logs (nohup.out - there can be several in various directories)" >> $dir2/nohup.out


