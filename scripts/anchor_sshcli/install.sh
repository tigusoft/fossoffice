#!/bin/bash
#ln -s or_sshcli/ ~/

mydir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
installdir="$HOME"

ln -s "$mydir" "$installdir/" || { echo "Can not make the symlink" ; exit 1 ; }

cd "$mydir"

cp conf-srv1.ex.sh  conf-srv1.local.sh
cp conf-srv2.ex.sh  conf-srv2.local.sh

echo "Ok, created symlink in $installdir"

echo "now will open editor for srv1 (vim)" ; read  _
vim conf-srv1.local.sh
echo "now will open editor for srv2 (vim)" ; read  _
vim conf-srv2.local.sh

echo "REMEMBER to follow other instructions from install.txt e.g. configure crontab, and so on!"

echo "Done"

