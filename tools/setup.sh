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

#install software
install_software() {
	clear
	print_log 'install software...'
    chmod +x $relative_location/../res/app/install.sh
    $relative_location/../res/app/install.sh
    print_log "done"
}

#config vim
config_vim() {
    clear
    print_log "do config for vim..."

    #check software
    check_software vim 'sudo apt -y install'
    check_software clang 'sudo apt -y install'
    check_software cmake 'sudo apt -y install'

    if [  -d "$HOME/dotfile" ]; then
        print_log "mv $HOME/dotfile to $HOME/dotfile.bak"
        mv $HOME/dotfile $HOME/dotfile.bak
    fi
    #git clone vim confi
    git clone https://github.com/imagine243/dotfile.git ~/dotfile

    # for .vimrc
    if [ -f "$HOME/.vimrc" ]; then
        print_log "mv $HOME/.vimrc to $HOME/.vimrc.bak"
        mv $HOME/.vimrc $HOME/.vimrc.bak
    fi
    # for .vim
    if [  -d "$HOME/.vim" ]; then
        print_log "mv $HOME/.vim to $HOME/.vim.bak"
        mv $HOME/.vim $HOME/.vim.bak
    fi

    # do config
    echo "source ~/dotfile/vim_config/init.vim" > $HOME/.vimrc
    # download vim plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +PlugInstall +qall
    print_log "done"
}

# config ssh for github
config_ssh() {
    clear
    print_log "config ssh for github..."
    chmod +x $relative_location/../res/ssh/ssh.sh
    $relative_location/../res/ssh/ssh.sh
    print_log "done"

}

clear
echo "Update System"
update_system
echo "wait 3s please..."

clear
echo "Install Softwares (res/app/apt)"
install_software
echo "wait 3s please..."

clear
echo "config vim"
config_vim
echo "wait 3s please..."
