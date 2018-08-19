#!/bin/sh

download_repo()
{
    echo "Downloading all config files from https://github.com/superyang713/\
vimrc-and-plugins"
    git clone https://github.com/superyang713/vimrc-and-plugins
    cd vimrc-and-plugins/vim_plugins/bundle/
    echo "Downloading vim plugins"
}

install_vimrc()
{
    echo "installing vimrc"
}

install_vim_plugins()
{
    echo "installing all vim plugins"
}

install_tmux_config()
{
    echo "installing tmux.config"
}

install_zshrc()
{
    echo "installing zsh"
    echo "installing oh-my-zsh"
    echo "installing zshrc and plugins"
}

cleanup()
{
    echo "cleaning up..."
    echo "removing unsed files..."
    rm -rf vimrc-and-plugins/
}

help_message()
{
    echo "If text is not displayed properly, please install the font"
}

echo "The installation will replace your current vimrc, zshrc, and vim plugins,
are you sure to proceed? (y/n)"

read resp

if [ $resp = "y" ]; then
    download_repo
    install_vimrc
    install_vim_plugins
    install_tmux_config
    install_zshrc
    help_message
    cleanup
else
    echo "oh no"
fi;
