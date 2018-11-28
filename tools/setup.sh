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

GUI=$(zenity --list --checklist \
  --height="500" \
  --width="1000" \
  --title="ubuntu bwg tool" \
  --text="Select your operation." \
  --column="Y/N" --column="Code"	--column="description" \
  TRUE "1" "Update Your System" \
  FALSE "2" "Install Softwares (res/app/pacman and res/app/yaourt" \
  FALSE "3" "Configure Vim (my vimrc, vundle, youcompleteme, etc..." \
  FALSE "4" "Configure Zsh (install oh-my-zsh and a new zshrc file)" \
  FALSE "5" "Generate SSH-KEYRING (for github or other applications)" \
  FALSE "6" "Configure Terminator" \
  --separator=" ");


if [[$GUI]]
then
	if [[ $GUI == *"1"* ]]
	then
		clear
		echo "Update System"
		update_system
		echo "wait 3s please..."
	fi
fi


