#! /bin/bash

echo ">>>ARCH-BASED DISTRO"
# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh scripts/arch/install.sh <ADMIN_USERNAME>"
  exit 1
fi

cwd=$(pwd)
scripts=$cwd/scripts
pkgs=$scripts/arch
client_home=/home/$1


# SETUP {{{

    echo ">>>SETUP\n"
    sudo pacman -Syu --needed < $pkgs/base_pkgs.txt

# }}}


# PKG INSTALL {{{

    # PARU {{{

        echo -e "\n\n>>>INSTALLING paru (ASSUMING YAY IS INSTALLED)\n"
        # currently using endevor which ships with yay
        yay -S paru

    # }}}


    # SOFTWARE {{{

        echo -e "\n\n>>>INSTALLING software\n"
        paru -S < $pkgs/langs_pkgs.txt < $pkgs/sys_sw_pkgs.txt \
                < $pkgs/sw_pkgs.txt < $pkgs/txt_editor_pkgs.txt

        # git credential manager (email git patches)
        cpan Authen::SASL MIME::Base64 Net::SMTP::SSL

        # nvim plugin dependency
        sudo npm i -g yarn

        # enos bspwm (do before dotfile copy, don't overwrite dots)
        git clone https://github.com/EndeavourOS-Community-Editions/bspwm.git
        cd bspwm
        bash bspwm-install.sh
        cd $cwd
        rm -rf bspwm

    # }}}


    # RUST {{{

        echo -e "\n\n>>>INSTALLING rust\n"
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

# }}}


# DOTFILES {{{

    echo -e "\n\n>>>STOWing dotfiles\n"
    # if we don't create the nvim dir, stow will symlink the entire directory.
    # vimplug will be installed later, and we don't want it stored in the
    # dotfile repo (which would happen if .config/nvim was a symlink)
    mkdir -p $client_home/.config/nvim

    stow --adopt .
    git restore .

    ln -s root/etc/pulse /etc
    ln -s root/etc/systemd/system/* /etc/systemd/system
    ln -s root/etc/wireplumber /etc

# }}}


# SYSTEM DAEMONS {{{

    echo -e "\n\n>>>ENABLING system daemons\n"

    # LIQUIDCTL {{{

        is_desktop=$(hostname | grep lavender)
        if [ "$is_desktop" ]; then
            systemctl enable liquidcfg.service
            systemctl start liquidcfg.service
        fi

    # }}}


    # UDISKIE {{{

        systemctl enable --user udiskie-lifesupport.service
        systemctl start --user udiskie-lifesupport.service

    # }}}

# }}}


# FONTS {{{

    echo -e "\n\n>>>INSTALLING fonts\n"
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
    fc-cache -f -v
    cd $cwd
    rm -rf ./downloads

# }}}


# WALLPAPERS {{{

    echo -e "\n\n>>>SETTING UP wallpapers\n"
    cp "${cwd}/images/wallpaper*" $client_home/Pictures

    bspwm_exists=$(which bspwm | grep bspwm)
    if [ "$bspwm_exists" ]; then
        echo -e "\t...bspwm detected, using nitrogen"
        nitrogen --no-recurse $client_home/Pictures
    else
        echo -e "...window manager not supported"
    fi

# }}}


# CONFIGURE {{{

    echo -e "\n\n>>>CONFIGURING installed software\n"

    # ZSH {{{

        sudo usermod --shell $(which zsh) "$1"
        mkdir -p $client_home/.zsh
        git clone https://github.com/sindresorhus/pure.git $client_home/.zsh/pure

    # }}}


    # RANGER {{{

        git clone https://github.com/alexanderjeurissen/ranger_devicons \
            $client_home/.config/ranger/plugins/ranger_devicons
        ranger --copy-config=all

    # }}}


    # QMK {{{

        git clone git@github.com:salvrz/qmk_firmware.git \
            $client_home/.config/qmk_firmware
        qmk setup -H $client_home/.config/qmk_firmware
        qmk config user.keyboard=boardsource/unicorne
        qmk config user.keymap=salvar_colemak_dh_matrix

    # }}}


    # VSCODE {{{

        sh $scripts/vscode_extensions.sh

    # }}}


    # VIM {{{

        curl -fLo $client_home/.vim/autoload/plug.vim --create-dirs \
              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        vim -c "PlugInstall"
        vim -c "CocInstall coc-json coc-tsserver"
        vim -c "CocInstall coc-rust-analyzer"

    #}}}


    # NVIM {{{

        curl -fLo $client_home/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim --headless +PlugInstall +qa

    # }}}


    # GIT EMAIL {{{

        git-credential-manager configure

        gpg --gen-key
        echo ">>>UPDATE run \`pass init <gpg-id>\` with the gpg id generated bellow. Press enter when you're done."
        echo ">>>HINT use the key-code after the \'pub\' identifier for the id."
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


    # MUTT/NEOMUTT {{{

        mkdir $client_home/.mutt
        mkdir $client_home/patch

        # curl https://gitlab.com/api/v4/projects/4815250/repository/files/contrib%2fmutt_oauth2.py/raw\?ref\=master > $client_home/.mutt/mutt_oauth2.py

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

echo ">>>IMPORTANT update kernel parameters (if needed) for mouse jumping...\n"
echo "How to update kernel params (/etc/kernel/cmdline or /efi/loader/entries): https://discovery.endeavouros.com/installation/systemd-boot/2022/12/\n"
echo "How to fix cursor jump (add `i8042.nomux=1` to params): https://wiki.archlinux.org/title/Touchpad_Synaptics#Cursor_jump"

exit 0
