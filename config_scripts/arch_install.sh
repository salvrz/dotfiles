#! /bin/bash

echo ">>>ARCH-BASED DISTRO"

# ensure admin username provided
if [[ $# -lt 0 ]]; then
  echo "Usage: sh arch_install.sh <ADMIN_USERNAME>"
  exit 1
else
  pwd
  sudo pacman -Syu
  sudo pacman -S --needed git
  sudo pacman -S base-devel bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python rsync tar xz
  sudo pacman -S neofetch

  echo ">>>INSTALLING zsh"
  sudo pacman -S zsh
  sudo usermod --shell $(which zsh) "$1"

  sudo sh ./config_scripts/arch_fresh_install.sh "$1"
  exit 0
fi

exit 1
