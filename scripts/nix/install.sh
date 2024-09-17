#! /bin/bash

echo ">>>NIX"
# ensure admin username provided
if [[ $# -lt 2 ]]; then
    echo "Usage: sh scripts/nix/install.sh <ADMIN_USERNAME> <FLAKE/SYS_NAME>"
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


# DOTFILES {{{

    echo -e "\n\n>>>STOWing dotfiles\n"
    # if we don't create the nvim dir, stow will symlink the entire directory.
    # vimplug will be installed later, and we don't want it stored in the
    # dotfile repo (which would happen if .config/nvim was a symlink)
    mkdir -p $client_home/.config/nvim

    ln -s $cwd/nix $client_home/.nix
    sudo nixos-rebuild switch --flake "$(readlink -f $(cwd)/.nix)"#$(2)

    #ln -s root/etc/pulse /etc
    #ln -s root/etc/systemd/system/* /etc/systemd/system
    #ln -s root/etc/wireplumber /etc

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

# }}}

exit 0
