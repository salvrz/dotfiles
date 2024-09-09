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


    # GIT CREDENTIALS {{{

        echo "...git credential management"
        paru -S gnupg
        paru -S pinentry  # gnupg uses for password prompt
        paru -S pass
        paru -S git-credential-manager-core
        cpan Authen::SASL MIME::Base64 Net::SMTP::SSL

        # FOR UBUNTU: install gcm via tarball from github

        echo ">>>CONFIGURING git credential manager"
        cp "${cwd}/home/.config/.gitconfig" $client_home/.gitconfig
        git-credential-manager configure

        echo ">>>UPDATE run \`pass init <gpg-id>\` with the gpg id generated bellow. Press enter when you're done."
        echo ">>>HINT use the key-code after the \'pub\' identifier for the id."
        gpg --gen-key
        read -n 1 -s  # wait for user input
        # user should run pass init <gpg-id> here

        echo ">>>UPDATE you must configure google apppasswords to send email via git. See step 4 of this guide:\nhttps://stackoverflow.com/questions/68238912/how-to-configure-and-use-git-send-email-to-work-with-gmail-to-email-patches-to"
        echo ">>>After you generate an apppassword, create a patch and use git-email to send it to yourself. Enter the password when prompted."
        echo ">>>Press enter when you're done."
        read -n 1 -s  # wait for user input

        echo ">>>UPDATE you must configure an ssh key with github. See:\nhttps://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
        echo ">>>Press enter when you're done."
        read -n 1 -s  # wait for user input

    # }}}

# }}}


# FONTS {{{

    echo ">>>INSTALLING fonts"
    echo"\t...IBM Plex Mono"
    echo"\t...NERDFont Blex"
    echo"\t...Font Awesome"
    # prep dirs
    sudo mkdir -p /usr/local/share/fonts
    sudo mkdir -p /usr/share/fonts/opentype

    # fetch fonts
    curl -fsLO --output-dir ./downloads/ --create-dirs https://github.com/IBM/plex/releases/download/v6.0.0/TrueType.zip
    # NERDFonts are NECESSARY for ranger icons to work
    curl -fsLO --output-dir ./downloads/ --create-dirs https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip
    curl -fsLO --output-dir ./downloads/ --create-dirs https://use.fontawesome.com/releases/v6.2.0/fontawesome-free-6.2.0-desktop.zip

    cd ./downloads

    # unzip fonts
    unzip TrueType.zip
    unzip IBMPlexMono.zip
    unzip fontawesome-free-6.2.0-desktop.zip

    # remove zips/conflicting fonts
    rm TrueType.zip
    rm IBMPlexMono.zip
    rm Blex*Compatible.ttf
    rm fontawesome-free-6.2.0-desktop.zip

    # download fonts
    sudo mv ./TrueType/IBM-Plex-Mono/*.ttf /usr/local/share/fonts/
    sudo mv ./fontawesome-free-6.2.0-desktop/otfs/* /usr/share/fonts/opentype/
    rm -rf TrueType/
    rm -rf fontawesome-free-6.2.0-desktop/
    sudo mv * /usr/local/share/fonts/

    # cleanup
    fc-cache
    cd $cwd
    rm -rf ./downloads

# }}}


# DOTFILES {{{

    echo ">>>COPYING dotfiles"

    echo "\t...copying ${1}'s home dir"
    cp -r $cwd/home/* $client_home

    echo "\t...copying root"
    sudo cp -r $cwd/root/* /

# }}}
