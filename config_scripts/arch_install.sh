#! /bin/bash

echo ">>>ARCH-BASED DISTRO"

# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
else
  pwd
  sudo pacman -Syu
  sudo pacman -S --needed git base-devel
  sudo pacman -S neofetch

  echo ">>>INSTALLING zsh"
  sudo pacman -S zsh
  sudo usermod --shell $(which zsh) "$1"

  echo ">>>INSTALLING rust"
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  cwd=$(pwd)
  exec "sudo sh ${pwd}/config_scripts/arch_fresh_install.sh ${1}"
  exit 0
fi

exit 1
