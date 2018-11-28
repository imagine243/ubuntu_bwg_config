#!/bin/bash

exec_location=`pwd`
relative_location=$(cd "$(dirname "$0")"; pwd)

LOG=$relative_location/../log

# print log
print_log() {
    echo -e  "\033[0;31;1m==> $1\033[0m"
    echo $1 >> $LOG
}

# check software
check_software() {
    echo "-> checking app $1..."
    which $1 >> /dev/null
    if [ $? = 0 ]; then
        echo "-> $1 had been installed"
    else
        echo "-> $1 has not been installed, installing now"
        sudo $2 $1
    fi
}

# update system
update_system() {
    clear
    print_log "update system..."
    check_software wget "sudo apt-get -y install"
	sudo apt-get update
	sudo apt-get upgrade
    print_log "done"
}


clear
echo "Update System"
update_system
echo "wait 3s please..."


