#! /bin/zsh

# setup
echo ">>>SETUP..."
cwd=$(pwd)
config="${cwd}/.config"
client_home="/home/${1}"

echo ">>>INSTALLING direnv"
sudo pacman -S direnv

echo ">>>CONFIGURING X server"
cp "${config}/xresources-cp" $client_home/.Xresources


# KEY BINDINGS {{{

  echo ">>>CONFIGURING key bindings vis sxhkd"
  cp -r "${config}/sxhkd/*" $client_home/.config/sxhkd

# }}}


# NODEJS & NPM {{{

  echo ">>>INSTALLING nodejs & npm"
  sudo pacman -S nodejs
  sudo pacman -S npm

# }}}


# RUST {{{
      
  echo ">>>INSTALLING rust"
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  exec  # restart shell

  rustup install stable
  rustup component add rust-src
  source "$client_home/.cargo/env"
  tset
  git clone https://github.com/rust-lang/rust-analyzer.git
  cd rust-analyzer
  cargo xtask install
      
# }}} 


# PARU {{{

  echo ">>>INSTALLING paru (ASSUMING YAY IS INSTALLED)"
  yay -S paru

# }}}


# UDISKIE {{{

  echo ">>>INSTALLING udiskie"
  paru -S udiskie

# }}}


# LINUX ZEN {{{

  echo ">>>CONFIGURING linux zen kernal"
  paru -S linux-zen
  paru -S linux-zen-headers
  sudo grub-mkconfig -o /boot/grub/grub.cfg

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


# GIT CREDENTIALS {{{

  echo ">>>CONFIGURING git credential management"
  echo ">>>INSTALLING git credential manager"
  paru -S gnupg
  paru -S pinentry  # gnupg uses for password prompt
  paru -S pass
  paru -S git-credential-manager-core
  cpan Authen::SASL MIME::Base64 Net::SMTP::SSL

  # FOR UBUNTU: install gcm via tarball from github

  echo ">>>CONFIGURING git credential manager"
  cp "${config}/git/gitconfig" $client_home/.gitconfig
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


# TERMINAL {{{

  echo ">>>CONFIGURING terminal"

  # ALACRITTY {{{

    echo ">>>INSTALLING alacritty"
    paru -S alacritty
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

  # EMAIL {{{

  echo ">>>CONFIGURING email clients"

    # MUTT/NEOMUTT {{{

      echo ">>>INSTALLING mutt and neomutt"
      paru -S mutt
      paru -S neomutt

      echo ">>>CONFIGURING mutt"

      # Place config files
      mkdir $client_home/.mutt
      #curl https://gitlab.com/api/v4/projects/4815250/repository/files/contrib%2fmutt_oauth2.py/raw\?ref\=master > $client_home/.mutt/mutt_oauth2.py
      cp -r "${config}/mutt" $client_home/.mutt
      mkdir $client_home/patch  # dir to save patches from mutt to

      # set up gpg key
      gpg --gen-key

      # have user configure oauth2 for mutt
      echo ">>>CONFIGURE mutt_oauth2.py (see https://www.redhat.com/sysadmin/mutt-email-oauth2)"
      echo ">>>press ENTER when mutt_oauth2.py is configured with gmail"
      read -n 1 -s  # wait for user input
      echo ">>>INSTRUCTIONS: for the following prompt, specify in this order:\ngoogle\nauthcode\n<your email>\n\n"
      sh $client_home/.mutt/oauth/refresh_token.sh

    # }}}

  #}}}

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


  # HTOP {{{
      
    echo ">>>INSTALLING htop"
    paru -S htop
      
  # }}}


  # BOTTOM {{{

    echo ">>>INSTALLING bottom"
    paru -S bottom

  # }}}


  # VTOP {{{

    echo ">>>INSTALLING vtop"
    sudo npm install -g vtop

  # }}}


  # GTOP {{{

    echo ">>>INSTALLING gtop"
    sudo npm install -g gtop

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
    sudo paru -S python
    sudo paru -S python-pip
    sudo paru -S ipython
    # brew install poetry
    pip install -U pytest
      
  # }}}


  # JAVA {{{
      
    echo ">>>INSTALLING java"
    sudo paru -S jdk11-openjdk  # openjdk java 11
      
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
    paru -S slack-desktop

  # }}}


  # MUSIC (spotify & mdp) {{{

    echo ">>>INSTALLING spotify"
    paru -S spotify-launcher
    
  # }}}


  # PROTONVPN {{{
    
  # }}}


  # POWERLINE {{{
    
  # }}}


  # C config {{{

    echo ">>>CONFIGURING C dev environment"

    # CSCOPE {{{

      echo ">>>INSTALLING cscope"
      paru -S cscope

    # }}}


    # CMAKE {{{  NOTE: this is a prereq for ccls

      echo ">>>INSTALLING cmake (prereq for ccls)"
      paru -S cmake

    # }}}


    # LLVM {{{  NOTE: this is a prereq for ccls

      echo ">>>INSTALLING llvm (prereq for ccls)"
      paru -S llvm

    # }}}


    # CLANG {{{  NOTE: this is a prereq for ccls

      echo ">>>INSTALLING clang (prereq for ccls)"
      paru -S clang

    # }}}


    # CCLS {{{

      echo ">>>INSTALLING ccls"
      paru -S ccls-git

    # }}}

  # }}}


  # VIM {{{
      
    echo ">>>INSTALLING vim"
    paru -S vim
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
    paru -S neovim
    paru -S ranger
    paru -S ueberzug
    paru -S xsel
    pip install pynvim
    pip install pynvim --upgrade
    sudo npm i -g yarn
    paru -S ripgrep  # telescope.nvim dependency
    mkdir $client_home/.config/nvim

    echo ">>>CONFIGURING nvim"
    cp -r "${config}/nvim" $client_home/.config

    echo ">>>INSTALLING vim plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    curl -fLo $client_home/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo ">>>CONFIGURING nvim ranger"
    git clone https://github.com/alexanderjeurissen/ranger_devicons $client_home/.config/ranger/plugins/ranger_devicons
    ranger --copy-config=all
    rcl=~/.config/ranger/rc.conf
    echo '# My Configurations' >> $rcl
    echo 'set show_hidden true' >> $rcl
    echo 'set draw_borders both' >> $rcl
    echo 'default_linemode devicons' >> $rcl

    echo "In ~/.config/ranger/rifle.conf, append each filetype line that has 'php' in it with 'rs'"
    echo "\nFor example:"
    echo "...py|pl|rb|js|sh|php = ask"
    echo "=> ...py|pl|rb|js|sh|php|rs = ask"
    read -n 1 -s  # wait for user input

    echo ">>>FINALIZE nvim plugins"
    nvim --headless +PlugInstall +qa
    # for vimscript config:
    # nvim --headless +'CocInstall coc-rust-analyzer coc-json coc-python coc-snippets coc-vimlsp' +qa

  # }}}


  # POLYBAR {{{
  
    echo ">>>CONFIGURING polybar"
    paru -S ttf-iosevka-nerd
    git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
    mv ./polybar-themes $client_home/polybar-themes
    cd $client_home/polybar-themes
    chmod +x setup.sh
    ./setup.sh
    cd $cwd
    cp -r "${config}/polybar/*" $client_home/.config/polybar/
  
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


  # LATEX {{{

    echo ">>>INSTALLING latex apps"

    paru -S texlive-basic texlive-latex texlive-latexrecommended texlive-latexextra texlive-binextra

  # }}}

# }}}


# SERVICES {{{

  echo ">>>CONFIGURING services"

  # LIQUIDCTL {{{

     echo ">>>CONFIGURING liquidcfg"
     cp "${config}/systemd/liquidcfg.service" /etc/systemd/system/
     systemctl enable liquidcfg.service
     systemctl start liquidcfg.service

  # }}}


  # UDISKIE {{{

    echo ">>>CONFIGURING udiskie"
    cp "${config}/systemd/udiskie-lifesupport.service" "${client_home}/.config/systemd/user/"
    systemctl enable --user udiskie-lifesupport.service
    systemctl start --user udiskie-lifesupport.service

  # }}}

# }}}
