
cd ~

rm -f ssh.log.7
mv ssh.log.6 ssh.log.7 
mv ssh.log.5 ssh.log.6
mv ssh.log.4 ssh.log.5
mv ssh.log.3 ssh.log.4
mv ssh.log.2 ssh.log.3
mv ssh.log.1 ssh.log.2
mv ssh.log   ssh.log.1

rm -f nohup.out.1
mv nohup.out  nohup.out.1
touch nohup.out

touch ssh.log
logdate=$(date) ; echo "[$logdate] Rotated the logs" >> ~/ssh.log

