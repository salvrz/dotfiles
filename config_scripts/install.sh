#! /bin/zsh

# SETUP {{{

    echo ">>>SETUP..."
    cwd=$(pwd)
    config="${cwd}/.config"
    client_home="/home/${1}"

# }}}

# PARU {{{

    echo ">>>INSTALLING paru (ASSUMING YAY IS INSTALLED)"
    yay -S paru

# }}}


# DIRENV {{{

    echo ">>>INSTALLING direnv"
    sudo pacman -S direnv

# }}}


# LANGUAGES {{{

    echo ">>>INSTALLING languages & package managers"

    # NODEJS & NPM {{{

        echo "\t...nodejs & npm"
        sudo pacman -S nodejs
        sudo pacman -S npm

    # }}}


    # RUST {{{

        echo "\t...rust"
        sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

        # TODO this doesn't quite work, 

        echo ">>>USER INTERACTION REQUIRED"
        echo"!!!finish installing rust!!!"
        echo"!!!finish installing rust-analyzer!!!"
        echo"!!!update this install code!!!"
        read -n 1 -s  # wait for user input
        #rustup install stable
        #rustup component add rust-src
        #source "$client_home/.cargo/env"
        #tset
        #git clone https://github.com/rust-lang/rust-analyzer.git
        #cd rust-analyzer
        #cargo xtask install

    # }}}

# }}}


# SYSTEM SOFTWARE {{{

    echo ">>>INSTALLING system software"

    # AUDIO {{{

        echo "\t...wireplumber"
        paru -S wireplumber
    
    # }}}


    # UDISKIE {{{

        echo "\t...udiskie"
        paru -S udiskie

    # }}}

# }}}


# PERSONAL SOFTWARE {{{

    echo ">>>INSTALLING personal software"
    # ZSH {{{

        echo "\t...pure (zsh)"
        mkdir -p $client_home/.zsh
        sudo git clone https://github.com/sindresorhus/pure.git $client_home/.zsh/pure

    # }}}

# }}}


# DOTFILES {{{

    echo ">>>COPYING dotfiles"

    echo "\t...copying ${1}'s home dir"
    cp -r $cwd/home/* $client_home

    echo "\t...copying root"
    sudo cp -r $cwd/root/* /

# }}}
