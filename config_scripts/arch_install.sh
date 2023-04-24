#! /bin/bash

# ensure admin username provided
if (($# < 1)) then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
fi

sudo pacman -Syu
echo ">>>INSTALLING zsh"
sudo pacman -S zsh
chsh -s $(which zsh)
su -c .config_scripts/arch_fresh_install.sh $1
