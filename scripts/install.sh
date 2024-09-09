#! /bin/bash

echo ">>>ARCH-BASED DISTRO"
# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh install.sh <ADMIN_USERNAME>"
  exit 1
fi


# SETUP {{{

    echo ">>>SETUP"
    sudo pacman -Syu
    sudo pacman -S --needed git
    sudo pacman -S base-devel bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python rsync tar xz valgrind gdb neofetch

    cwd=$(pwd)
    config="${cwd}/.config"
    client_home="/home/${1}"

# }}}


# PARU {{{

    echo ">>>INSTALLING paru (ASSUMING YAY IS INSTALLED)"
    yay -S paru

# }}}


# LANGUAGES {{{

    echo ">>>INSTALLING languages & package managers"

    # NODEJS & NPM {{{

        echo "\t...nodejs & npm"
        paru -S nodejs
        paru -S npm

    # }}}


    # C {{{

        echo "\t...C lang utils"
        paru -S cscope cmake llvm clang ccls

    # }}}


    # RUST {{{

        echo "\t...rust"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

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


    # PYTHON {{{

        echo "\t...python"
        paru -S python python-pip ipython
        # brew install poetry
        pip install -U pytest

    # }}}


    # JAVA {{{

        echo "\t...java"
        sudo paru -S jdk11-openjdk  # openjdk java 11

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

    # DIRENV {{{

        echo "\t...direnv"
        paru -S direnv

    # }}}


    # ZSH {{{

        echo "\t...pure (zsh)"
        paru -S zsh
        sudo usermod --shell $(which zsh) "$1"
        mkdir -p $client_home/.zsh
        git clone https://github.com/sindresorhus/pure.git $client_home/.zsh/pure

    # }}}


    # ALACRITTY {{{

        echo "\t...alacritty"
        paru -S alacritty

    # }}}


    # GIT CREDENTIALS {{{

        echo "\t...git credential management"
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


    # SCREEN {{{

        echo "\t...screen"
        paru -S screen

    # }}}


    # DOCUMENTATION {{{

        echo "\t...asciidoc and xmlto"
        paru -S asciidoc xmlto

    # }}}


    # QALCULATE! {{{

        echo "\t...qualculate"
        paru -S qalculate-gtk

    # }}}


    # HTOP {{{

        echo "\t...htop"
        paru -S htop

    # }}}


    # BOTTOM {{{

        echo "\t...bottom"
        paru -S bottom

    # }}}


    # MESSAGING {{{

        echo "\t...messaging apps (discord, etc.)"
        paru -S discord slack-desktop

    # }}}


    # MUSIC {{{

        echo "\t...spotify"
        paru -S spotify-launcher

    # }}}


    # REPGREP {{{

        echo "\t...repgrep (nvim telescope dependency)"
        paru -S ripgrep

    # }}}


    # RANGER {{{

        echo "\t...ranger"
        paru -S ranger
        git clone https://github.com/alexanderjeurissen/ranger_devicons $client_home/.config/ranger/plugins/ranger_devicons
        ranger --copy-config=all

    # }}}


    # LATEX {{{

        echo  "\t...latex"
        paru -S texlive-basic texlive-latex texlive-latexrecommended texlive-latexextra texlive-binextra

    # }}}


    # QMK {{{

        # reference: https://docs.qmk.fm/#/newbs_building_firmware
        echo "\t...qmk"
        sudo pacman -S qmk

        git clone git@github.com:salvrz/qmk_firmware.git $client_home/.config/qmk_firmware
        qmk setup -H $client_home/.config/qmk_firmware
        qmk config user.keyboard=boardsource/unicorne
        qmk config user.keymap=salvar_colemak_dh_matrix

    # }}}


    # INTERNET {{{

        echo "\t...internet utils"
        paru -S networkmanager nmtui

    # }}}


    # MUTT/NEOMUTT {{{

        echo "\t...mutt and neomutt"
        paru -S mutt
        paru -S neomutt

        mkdir $client_home/.mutt
        mkdir $client_home/patch  # dir to save patches from mutt to

        #curl https://gitlab.com/api/v4/projects/4815250/repository/files/contrib%2fmutt_oauth2.py/raw\?ref\=master > $client_home/.mutt/mutt_oauth2.py
        cp -r "${cwd}/home/.mutt" $client_home

        # set up gpg key
        gpg --gen-key

        # have user configure oauth2 for mutt
        echo ">>>CONFIGURE mutt_oauth2.py (see https://www.redhat.com/sysadmin/mutt-email-oauth2)"
        echo ">>>press ENTER when mutt_oauth2.py is configured with gmail"
        read -n 1 -s  # wait for user input
        echo ">>>INSTRUCTIONS: for the following prompt, specify in this order:\ngoogle\nauthcode\n<your email>\n\n"
        sh $client_home/.mutt/oauth/refresh_token.sh

    # }}}

# }}}


# TEXT EDITORS {{{

    echo ">>>INSTALLING text editors"

    # VSCODE {{{

        echo "\t...vscode"
        paru -S visual-studio-code-bin
        sh $cwd/scripts/vscode_extensions.sh

    # }}}


    # VIM {{{

        echo "\t...vim & vimplug"
        paru -S vim
        curl -fLo $client_home/.vim/autoload/plug.vim --create-dirs \
              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # }}}


    # NVIM {{{

        echo "\t...nvim & vimplug"
        paru -S neovim ueberzug xsel python-pynvim
        sudo npm i -g yarn

        curl -fLo $client_home/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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


# SYSTEM DAEMONS {{{

    echo">>>INSTALLING system daemons"

    # LIQUIDCTL {{{

        is_desktop=$(hostname | grep lavender)
        if [ "$is_desktop" ]; then
            echo "\t...liquidcfg"
            systemctl enable liquidcfg.service
            systemctl start liquidcfg.service
        fi

    # }}}


    # UDISKIE {{{

        echo "\t...udiskie"
        systemctl enable --user udiskie-lifesupport.service
        systemctl start --user udiskie-lifesupport.service

    # }}}

# }}}


# WALLPAPERS {{{

    echo ">>>SETTING UP wallpapers"
    cp "${cwd}/images/wallpaper*" $client_home/Pictures

    bspwm_exists=$(which bspwm | grep bspwm)
    if [ "$bspwm_exists" ]; then
        echo "\t...bspwm detected, using nitrogen"
        paru -S nitrogen
        nitrogen --no-recurse $client_home/Pictures
    else
        echo "...window manager not supported"
    fi

# }}}


# FINALIZE {{{

    echo ">>>FINALIZING"

    # VIMPLUG {{{

        echo "\t...vimplug"
        vim -c "PlugInstall"
        vim -c "CocInstall coc-json coc-tsserver"
        vim -c "CocInstall coc-rust-analyzer"

    # }}}


    # NVIM {{{

        echo "\t...nvim vimplug"
        nvim --headless +PlugInstall +qa

    # }}}

# }}}

exit 0
