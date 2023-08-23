#! /bin/bash

echo ">>>ARCH-BASED DISTRO"

# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
else
  pwd
  pacman -Syu

  echo ">>>INSTALLING zsh"
  pacman -S zsh
  sudo usermod --shell $(which zsh) "$1"

  sudo ./config_scripts/arch_fresh_install.sh "$1"
  exit 0
fi

exit 1
