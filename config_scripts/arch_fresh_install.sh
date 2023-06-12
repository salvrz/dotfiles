#! /bin/zsh

# setup
echo ">>>SETUP..."
pwd
cwd=$(pwd)
config="${cwd}/.config"
client_home="/home/${1}"

sudo pacman -Syu
sudo pacman -S --needed git base-devel
sudo pacman -S neofetch

echo ">>>INSTALLING direnv"
sudo pacman -S direnv

echo ">>>CONFIGURING X server"
cp "${config}/xresources-cp" $client_home/.Xresources


# KEY BINDINGS {{{

  echo ">>>CONFIGURING key bindings vis sxhkd"
  cp "${config}/sxhkdrc-cp" $client_home/.config/sxhkd/sxhkdrc

# }}}


# RUST {{{
      
  echo ">>>INSTALLING rust"
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
  source "$client_home/.cargo/env"
  rustup component add rust-src
  zsh
      
# }}} 


# PARU {{{

  echo ">>>INSTALLING paru"
  git clone https://aur.archlinux.org/paru.git
  setfacl -m u:"$1":rwx paru
  cd paru
  sudo -u "$1" makepkg -sri
  cd $cwd
  rm -rf ./paru

# }}}


# YAY {{{
  
  echo ">>>INSTALLING yay"
  git clone https://aur.archlinux.org/yay-git.git
  setfacl -m u:"$1":rwx yay-git
  cd yay-git
  sudo -u "$1" makepkg -sri
  cd $cwd
  rm -rf yay-git

# }}}


# LINUX ZEN {{{

  echo ">>>CONFIGURING linux zen kernal"
  paru -S linux-zen
  paru -S linux-zen-headers
  sudo grub-mkconfig -o /boot/grub/grub.cfg

# }}}


# LIBSECRET {{{
    
  echo ">>>INSTALLING libsecret"
  sudo pacman -S libsecret
    
# }}}


# FONTS {{{
    
  echo ">>>INSTALLING IBM Plex Mono and NERDFont Blex"
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
  sudo rm -rf *
  fc-cache
  cd $cwd
    
# }}}


# BASH CONFIG {{{
    
  echo ">>>CONFIGURING bash"
  cp "${config}/shell/bashrc-cp" $client_home/.bashrc
    
# }}}


# ZSH {{{
    
  echo ">>>CONFIGURING zsh"
  mkdir -p $client_home/.zsh
  sudo git clone https://github.com/sindresorhus/pure.git "$client_home/.zsh/pure"
  cp "${config}/shell/zshrc-cp" $client_home/.zshrc
    
# }}}


# TERMINAL {{{

  echo ">>>CONFIGURING terminal"

  # ALACRITTY {{{

    echo ">>>INSTALLING alacritty"
    sudo pacman -S alacritty
    mkdir $client_home/.config/alacritty
    cp "${config}/terminal/alacritty-cp.yml" $client_home/.config/alacritty/alacritty.yml

  # }}}


  # SKEL PICOM {{{

    echo ">>>CONFIGURING skel (user terminal defaults)"
    sudo cp "${config}/picom.conf" /etc/skel/.config/picom.conf

  # }}}

# }}}


# SCREEN {{{

  paru -S screen

# }}}


# INTERNET {{{

  echo ">>>CONFIGURING internet"
  paru -S networkmanager
  paru -S rofi
  paru -S dunst
  paru -S nm-connection-editor
  git clone https://github.com/P3rf/rofi-network-manager.git
  sudo cp -r rofi-network-manager /opt/
  rm -rf rofi-network-manager

# }}}


# SOFTWARE {{{

  echo ">>>CONFIGURING software"

  # DOCUMENTATION {{{

    echo ">>>CONFIGURING documentation software"

    # ASCIIDOC {{{

    echo ">>>INSTALLING asciidoc"
    paru -S asciidoc

    # }}}


    # XMLTO {{{

    echo ">>>INSTALLING xmlto"
    paru -S xmlto

    # }}}

  # }}}


  # QALCULATE! {{{
  
    echo ">>>INSTALLING qualculate"
    paru -S qalculate-gtk
  
  # }}}


  # NODEJS & NPM {{{
      
    echo ">>>INSTALLING nodejs & npm"
    sudo pacman -S nodejs
    sudo pacman -S npm
      
  # }}}


  # HTOP {{{
      
    echo ">>>INSTALLING htop"
    sudo pacman -S htop
      
  # }}}


  # BREW {{{
      
    #echo ">>>INSTALLING brew"
    # brew currently not supported for ARM architechtures?
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/salvar/.zprofile
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/salvar/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      
  # }}}


  # PYTHON {{{
      
    echo ">>>INSTALLING python"
    sudo pacman -S python
    sudo pacman -S python-pip
    sudo pacman -S ipython
    # brew install poetry
    pip install -U pytest
      
  # }}}


  # JAVA {{{
      
    echo ">>>INSTALLING java"
    sudo pacman -S jdk-openjdk  # most recent version of openjdk java
    #sudo pacman -S jdk11-openjdk  # openjdk java 11
    # CURRENTLY DOESN'T INSTALL JUNIT
    # CURRENTLY DOESN'T INSTALL MAVEN
    #echo ">>>INSTALLING maven"
    # brew install maven
    #echo ">>>CONFIGURING npm w/ angular"
    #npm install -g @angular/cli 
      
  # }}}


  # VSCODE {{{
      
    echo ">>>INSTALLING vscode"
    paru -S visual-studio-code-bin
    sh "${config}/vscode/extensions.sh"
    cp "${config}/vscode/vscode_settings2.json" $client_home/.config/Code/User/settings.json
    # cp "${config}/vscode/vscode_settings1.json" $client_home/.config/Code/User/settings.json
      
  # }}}


  # DISCORD {{{
      
    echo ">>>INSTALLING discord"
    paru -S discord
      
  # }}}


  # SLACK {{{
    echo ">>>INSTALLING slack"
    yay -S slack-desktop

  # }}}


  # MUSIC (spotify & mdp) {{{

    echo ">>>INSTALLING spotify"
    sudo pacman -Syu spotify-launcher
    paru -S mpd
    
  # }}}


  # PROTONVPN {{{
    
  # }}}


  # POWERLINE {{{
    
  # }}}


  # CSCOPE {{{

    echo ">>>INSTALLING cscope"
    paru -S cscope

  # }}}


  # VIM {{{
      
    echo ">>>INSTALLING vim"
    sudo pacman -S vim
    cp "${config}/vim/vimrc-cp" $client_home/.vimrc

    echo ">>>INSTALLING vim plugs"
    curl -fLo $client_home/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c "PlugInstall"
    vim -c "CocInstall coc-json coc-tsserver"
    vim -c "CocInstall coc-rust-analyzer"
      
  # }}}


  # NVIM {{{
      
    echo ">>>INSTALLING nvim"
    sudo pacman -S neovim
    sudo pacman -S ranger
    paru -S python-ueberzug-git  # This will probably fail, not sure if package is necessary
    mkdir $client_home/.config/nvim

    echo ">>>INSTALLING vim plug plugins"
    curl -fLo $client_home/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp "${config}/nvim/init.vim" $client_home/.config/nvim/init.vim
    sudo pacman -S xsel
    pip install pynvim
    pip install pynvim --upgrade
    sudo npm i -g yarn
    git clone https://github.com/alexanderjeurissen/ranger_devicons $client_home/.config/ranger/plugins/ranger_devicons
    ranger --copy-config=all
    rcl=~/.config/ranger/rc.conf
    echo '# My Configurations' >> $rcl
    echo 'set show_hidden true' >> $rcl
    echo 'set draw_borders both' >> $rcl
    echo 'default_linemode devicons' >> $rcl

    echo ">>>CONFIGURING nvim"
    cp -r "${config}/nvim/general" $client_home/.config/nvim/
    cp -r "${config}/nvim/keys" $client_home/.config/nvim/
    cp -r "${config}/nvim/themes" $client_home/.config/nvim/
    cp -r "${config}/nvim/plug-config" $client_home/.config/nvim/
    cp -r "${config}/nvim/vim-plug" $client_home/.config/nvim/
    cp "${config}/nvim/coc-settings.json" $client_home/.config/nvim/coc-settings.json

    echo ">>>FINALIZE nvim plugins"
    nvim --headless +PlugInstall +qa
    nvim --headless +'CocInstall coc-rust-analyzer coc-json coc-python coc-snippets coc-vimlsp' +qa

  # }}}


  # POLYBAR {{{
  
    echo ">>>CONFIGURING polybar"
    cp "${config}/polybar/poly-config.ini" $client_home/.config/polybar/config.ini
    paru -S ttf-iosevka-nerd
    git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
    mv ./polybar-themes $client_home/polybar-themes
    cd $client_home/polybar-themes
    chmod +x setup.sh
    ./setup.sh
    cd $cwd
    cp "${config}/polybar/my_modules.ini" $client_home/.config/polybar/my_modules.ini
    cp "${config}/polybar/poly_themes_hack_conf.ini" $client_home/.config/polybar/hack/config.ini
  
  # }}}


  # BSPWM {{{

    echo ">>>CONFIGURING bspwm"
    bspwm_exists=$(which bspwm | grep bspwm)

    if [ "$bspwm_exists" ]; then
      echo ">>>CONFIGURING wallpapers"

      # wallpapers
      cp "${cwd}/images/wallpaper*" $client_home/Pictures/
      paru -S nitrogen
      nitrogen --no-recurse $client_home/Pictures/
      cp "${config}/bspwm/bspwmrc" $client_home/.config/bspwm/bspwmrc

      # lock screens
      sudo cp "${cwd}/.config/slick-greeter-cp" /etc/lightdm/slick-greeter.conf

    else
      echo ">>>NOT INSTALLED: bspwm, please install"
    fi

  # }}}

# }}}
