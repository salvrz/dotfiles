#! /bin/zsh

# SETUP {{{

    echo ">>>SETUP..."
    cwd=$(pwd)
    config="${cwd}/.config"
    client_home="/home/${1}"

# }}}


# DIRENV {{{

    echo ">>>INSTALLING direnv"
    sudo pacman -S direnv

# }}}


# DOTFILES {{{

    echo ">>>COPYING DOTFILES"

    echo "\t...copying ${1}'s home dir"
    cp -r $cwd/home/* $client_home

    echo "\t...copying root"
    sudo cp -r $cwd/root/* /

# }}}
