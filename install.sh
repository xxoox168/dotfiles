#!/bin/sh

download_repo()
{
    cd ~
    echo "Downloading all config files from Yang's repo"
    git clone --quiet https://github.com/superyang713/vimrc-and-plugins

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
    git clone --recursive --quiet https://github.com/python-mode/python-mode
    echo "Downloading sparkup..."
    git clone --quiet https://github.com/rstacruz/sparkup.git
    echo "Downloading tlib_vim..."
    git clone --quiet https://github.com/tomtom/tlib_vim.git
    echo "Downloading snippets..."
    git clone --quiet https://github.com/honza/vim-snippets.git
    git clone --quiet https://github.com/MarcWeber/vim-addon-mw-utils.git
    echo "Downloading snipmate..."
    git clone --quiet https://github.com/garbas/vim-snipmate.git
    echo "Downloading ctrlp..."
    git clone --quiet https://github.com/kien/ctrlp.vim.git
    echo "Downloading solarize..."
    git clone --quiet https://github.com/altercation/vim-colors-solarized.git
    echo "Downloading jedi-auto-complete..."
    git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
    echo "Downloading Markdown-Preview"
    git clone https://github.com/iamcco/markdown-preview.vim.git


    cd ~/vimrc-and-plugins
}

install_vimrc()
{
    echo "installing vimrc"
    cp vimrc ~/.vimrc
}

install_vim_plugins()
{
    echo "installing all vim plugins"
    rm -rf ~/.vim
    cp -r vim_plugins ~/.vim
}

install_tmux_config()
{
    echo "Transferring new tmux config file"
    cp tmux.conf ~/.tmux.conf
}

install_zsh()
{
    echo "Transfering .zshrc"
    cp zshrc ~/.zshrc
    echo "installing zsh"
    sudo apt install zsh
    echo "installing oh-my-zsh"
     # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
      RED="$(tput setaf 1)"
      GREEN="$(tput setaf 2)"
      YELLOW="$(tput setaf 3)"
      BLUE="$(tput setaf 4)"
      BOLD="$(tput bold)"
      NORMAL="$(tput sgr0)"
    else
      RED=""
      GREEN=""
      YELLOW=""
      BLUE=""
      BOLD=""
      NORMAL=""
    fi

    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    set -e

    if ! command -v zsh >/dev/null 2>&1; then
      printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
      exit
    fi

    if [ ! -n "$ZSH" ]; then
      ZSH=~/.oh-my-zsh
    fi

    if [ -d "$ZSH" ]; then
      printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
      printf "You'll need to remove $ZSH if you want to re-install.\n"
      exit
    fi

    # Prevent the cloned repository from having insecure permissions. Failing to do
    # so causes compinit() calls to fail with "command not found: compdef" errors
    # for users with insecure umasks (e.g., "002", allowing group writability). Note
    # that this will be ignored under Cygwin by default, as Windows ACLs take
    # precedence over umasks except for filesystems mounted with option "noacl".
    umask g-w,o-w

    printf "${BLUE}Cloning Oh My Zsh...${NORMAL}\n"
    command -v git >/dev/null 2>&1 || {
      echo "Error: git is not installed"
      exit 1
    }
    # The Windows (MSYS) Git is not compatible with normal use on cygwin
    if [ "$OSTYPE" = cygwin ]; then
      if git --version | grep msysgit > /dev/null; then
        echo "Error: Windows/MSYS Git is not supported on Cygwin"
        echo "Error: Make sure the Cygwin git package is installed and is first on the path"
        exit 1
      fi
    fi
    env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" || {
      printf "Error: git clone of oh-my-zsh repo failed\n"
      exit 1
    }

    # If this user's login shell is not already "zsh", attempt to switch.
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
      # If this platform provides a "chsh" command (not Cygwin), do it, man!
      if hash chsh >/dev/null 2>&1; then
        printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
        chsh -s $(grep /zsh$ /etc/shells | tail -1)
      # Else, suggest the user do so manually.
      else
        printf "I can't change your shell automatically because this system does not have chsh.\n"
        printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
      fi
    fi

    printf "${GREEN}"
    echo '         __                                     __   '
    echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
    echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
    echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
    echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
    echo '                        /____/                       ....is now installed!'
    echo ''
    echo ''

    finalize
}

finalize()
{
    echo "cleaning up..."
    echo "removing unsed files..."
    rm -rf ~/vimrc-and-plugins
    help_message
    env zsh -l
}

help_message()
{
    echo "If text is not displayed properly after terminal restart, please \
install the font -- Shure Tech Mono Nerd Font Complete Mono"
}

echo "The installation will replace your current vimrc, zshrc, and vim plugins,
are you sure to proceed? (y/n)"

read resp

if [ $resp = "y" ]; then
    download_repo
    install_vimrc
    install_vim_plugins

    source ~/.vimrc

    install_tmux_config
    install_zsh
else
    echo "oh no"
fi;
