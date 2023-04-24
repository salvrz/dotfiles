#! /bin/zsh

# setup
echo ">>>SETUP..."
pwd
cwd=$(pwd)
config=$"{cwd}/.config"

sudo -S pacman -Syu
sudo -S pacman -S --needed git base-devel
sudo -S pacman -S neofetch

echo ">>>INSTALLING direnv"
sudo -S pacman -S direnv

echo ">>>CONFIGURING X server"
cp "${config}/xresources-cp" ~/.Xresources


# KEY BINDINGS {{{

  echo ">>>CONFIGURING key bindings vis sxhkd"
  cp "${config}/sxhkdrc-cp" ~/.config/sxhkd/sxhkdrc

# }}}


# PARU {{{

  echo ">>>INSTALLING direnv"
  git clone https://aur.archlinux.org/paru.git
  sudo -S chown -R $USER:$USER ./paru 
  cd paru
  makepkg -si
  cd $cwd
  rm -rf ./paru

# }}}


# YAY {{{
  
  echo ">>>INSTALLING yay"
  git clone https://aur.archlinux.org/yay-git.git
  cd yay-git
  makepkg -sri
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
  sudo -S pacman -S libsecret
    
# }}}


# FONTS {{{
    
  echo ">>>INSTALLING IBM Plex Mono and NERDFont Blex"
  # prep dirs
  sudo -S mkdir -p /usr/local/share/fonts
  sudo -S mkdir -p /usr/share/fonts/opentype

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
  sudo -S mv ./TrueType/IBM-Plex-Mono/*.ttf /usr/local/share/fonts/
  sudo -S mv ./fontawesome-free-6.2.0-desktop/otfs/* /usr/share/fonts/opentype/
  rm -rf TrueType/
  rm -rf fontawesome-free-6.2.0-desktop/
  sudo -S mv * /usr/local/share/fonts/

  # cleanup
  sudo -S rm -rf *
  fc-cache
  cd $cwd
    
# }}}


# BASH CONFIG {{{
    
  echo ">>>CONFIGURING bash"
  cp "${config}/shell/bashrc-cp" ~/.bashrc
    
# }}}


# ZSH {{{
    
  echo ">>>CONFIGURING zsh"
  mkdir -p ~/.zsh
  sudo -S git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
  cp "${config}/shell/zshrc-cp" ~/.zshrc
    
# }}}


# TERMINAL {{{

  echo ">>>CONFIGURING terminal"

  # ALACRITTY {{{

    echo ">>>INSTALLING alacritty"
    sudo -S pacman -S alacritty
    mkdir ~/.config/alacritty
    cp "${config}/terminal/alacritty-cp.yml" ~/.config/alacritty/alacritty.yml

  # }}}


  # SKEL PICOM {{{

    echo ">>>CONFIGURING skel (user terminal defaults)"
    sudo cp "${config}/picom.conf" /etc/skel/.config/picom.conf

  # }}}

# }}}


# INTERNET {{{

  echo ">>>CONFIGURING internet"
  paru -S networkmanager
  paru -S rofi
  paru -S dunst
  paru -S nm-connection-editor
  git clone https://github.com/P3rf/rofi-network-manager.git
  mv -r rofi-network-manager ~/

# }}}


# SOFTWARE {{{

  echo ">>>CONFIGURING software"

  # QALCULATE! {{{
  
    echo ">>>INSTALLING qualculate"
    paru -S qalculate-gtk
  
  # }}}


  # NODEJS & NPM {{{
      
    echo ">>>INSTALLING nodejs & npm"
    sudo -S pacman -S nodejs
    sudo -S pacman -S npm
      
  # }}}


  # HTOP {{{
      
    echo ">>>INSTALLING htop"
    sudo -S pacman -S htop
      
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
    sudo -S pacman -S python
    sudo -S pacman -S python-pip
    sudo -S pacman -S ipython
    # brew install poetry
    pip install -U pytest
      
  # }}}


  # JAVA {{{
      
    echo ">>>INSTALLING java"
    sudo -S pacman -S jdk-openjdk  # most recent version of openjdk java
    #sudo -S pacman -S jdk11-openjdk  # openjdk java 11
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
    cp "${config}/vscode/vscode_settings2.json" ~/.config/Code/User/settings.json
    # cp "${config}/vscode/vscode_settings1.json" ~/.config/Code/User/settings.json
      
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


  # VIM {{{
      
    echo ">>>INSTALLING vim"
    sudo -S pacman -S vim
    cp "${config}/vim/vimrc-cp" ~/.vimrc

    echo ">>>INSTALLING vim plugs"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c "PlugInstall"
    vim -c "CocInstall coc-json coc-tsserver"
    vim -c "CocInstall coc-rust-analyzer"
      
  # }}}


  # NVIM {{{
      
    echo ">>>INSTALLING nvim"
    sudo -S pacman -S neovim
    sudo -S pacman -S ranger
    paru -S python-ueberzug-git  # This will probably fail, not sure if package is necessary
    mkdir ~/.config/nvim

    echo ">>>CONFIGURING nvim"
    mkdir ~/.config/nvim/general
    mkdir ~/.config/nvim/vim-plug
    mkdir ~/.config/nivm/keys
    mkdir ~/.config/nivm/plug-config
    mkdir ~/.config/nvim/themes
    cp "${config}/nvim/nvim-settings" ~/.config/nvim/general/settings.vim

    echo ">>>INSTALLING vim plugs for nvim"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp "${config}/nvim/plugins-vim-cp" ~/.config/nvim/vim-plug/plugins.vim
    cp "${config}/nvim/init-vim-cp" ~/.config/nvim/init.vim
    cp "${config}/nvim/mappings-vim-cp" ~/.config/nvim/keys/mappings.vim
    sudo -S pacman -S xsel
    pip install pynvim
    pip install pynvim --upgrade
    sudo -S npm i -g yarn
    cp "${config}/nvim/coc/coc-vim-cp" ~/.config/nvim/plug-config/coc.vim
    cp "${config}/nvim/coc/coc-settings-cp" ~/.config/nvim/coc-settings.json
    cp "${config}/nvim/vim-sunbather-cp" ~/.config/nvim/themes/vim-sunbather.vim
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    ranger --copy-config=all
    cp "${config}/nvim/ranger/rc-conf-cp" ~/.config/ranger/rc.conf
    cp "${config}/nvim/ranger/rnvimr-vim-cp" ~/.config/nvim/plug-config/rnvimr.vim
    cp "${config}/nvim/mime-types-cp" ~/.mime.types
    cp "${config}/nvim/rust-vim-cp" ~/.config/nvim/plug-config/rust.vim
    nvim --headless +PlugInstall +qa
    nvim --headless +'CocInstall coc-rust-analyzer coc-json coc-python coc-snippets coc-vimlsp' +qa

  # }}}


  # RUST {{{
      
    echo ">>>INSTALLING rust"
    sudo -S curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
    source "$HOME/.cargo/env"
    rustup component add rust-src
      
  # }}} 


  # POLYBAR {{{
  
    echo ">>>CONFIGURING polybar"
    cp "${config}/polybar/poly-config.ini" $HOME/.config/polybar/config.ini
    paru -S ttf-iosevka-nerd
    git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
    mv ./polybar-themes ~/polybar-themes
    cd ~/polybar-themes
    chmod +x setup.sh
    ./setup.sh
    cd $cwd
    cp "${config}/polybar/my_modules.ini" ~/.config/polybar/my_modules.ini
    cp "${config}/polybar/poly_themes_hack_conf.ini" ~/.config/polybar/hack/config.ini
  
  # }}}


  # BSPWM {{{

    echo ">>>CONFIGURING bspwm"
    bspwm_exists=$(which bspwm | grep bspwm)

    if [ "$bspwm_exists" ]; then
      cp "${cwd}/images/wallpaper*" ~/Pictures/
      paru -S nitrogen
      nitrogen --no-recurse ~/Pictures/
      cp "${config}/bspwm/bspwmrc" $HOME/.config/bspwm/bspwmrc

    else
      echo ">>>NOT INSTALLED: bspwm, please install"
    fi

  # }}}

# }}}
