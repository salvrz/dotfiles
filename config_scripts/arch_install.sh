#! /bin/bash

# ensure admin username provided
echo $1
if [[ $# -lt 0 ]]; then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
else
  sudo pacman -Syu
  echo ">>>INSTALLING zsh"
  sudo pacman -S zsh
  chsh -s $(which zsh)
  su -c .config_scripts/arch_fresh_install.sh $1
  exit 0
fi
exit 1
