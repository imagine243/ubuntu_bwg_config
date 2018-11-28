if [ -d "$HOME/." ];
then
    mv $HOME/.ubuntu_bwg_config $HOME/.ubuntu_bwg_config.bak
fi

git clone https://github.com/imagine243/ubuntu_bwg_config.git  $HOME/.ubuntu_bwg_config
cd $HOME/.ubuntu_bwg_config
./tools/setup.sh
