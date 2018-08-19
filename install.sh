#!/bin/sh

download_repo()
{
    echo "Downloading all config files from Yang's repo"
    git clone https://github.com/superyang713/vimrc-and-plugins

    echo "Preparing for vim plugins download"
    cd vimrc-and-plugins/vim_plugins/bundle/
    echo "Downloading nerdtree..."
    git clone --quiet https://github.com/jistr/vim-nerdtree-tabs.git
    git clone --quiet https://github.com/scrooloose/nerdtree.git
    echo "Downloading powerline..."
    git clone --quiet https://github.com/powerline/powerline.git
    echo "Downloading sensible..."
    git clone --quiet https://github.com/tpope/vim-sensible.git
    echo "Downloading python-mode..."
    git clone --quiet --recursive https://github.com/python-mode/python-mode
    echo "Downloading sparkup..."
    git clone --quiet https://github.com/rstacruz/sparkup.git
    echo "Downloading tlib_vim..."
    git clone --quiet https://github.com/tomtom/tlib_vim.git
    echo "Downloading snippets..."
    git clone --quiet https://github.com/honza/vim-snippets.git
    echo "Downloading snipmate..."
    git clone --quiet https://github.com/garbas/vim-snipmate.git
    echo "Downloading ctrlp..."
    git clone --quiet https://github.com/kien/ctrlp.vim.git
    echo "Downloading solarize..."
    git clone --quiet https://github.com/altercation/vim-colors-solarized.git

    cd ../../../
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