#!/bin/bash
#ln -s or_sshcli/ ~/

mydir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
installdir="$HOME"

ln -s "$mydir" "$installdir/" || { echo "Can not make the symlink" ; exit 1 ; }

echo "Ok, created symlink in $installdir"

echo "REMEMBER to follow other instructions from install.txt e.g. configure crontab, and so on!"

echo "Done"

