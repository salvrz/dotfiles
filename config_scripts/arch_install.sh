#! /bin/bash

# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
else
  pacman -Syu
  echo ">>>INSTALLING zsh"
  pacman -S zsh
  su -c chsh -s $(which zsh) $1
  echo "testing"
  sudo ./config_scripts/arch_fesh_install.sh "$1"
  #su -c ./config_scripts/arch_fresh_install.sh $1
  exit 0
fi
exit 1
