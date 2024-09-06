#! /bin/zsh

# setup
echo ">>>SETUP..."
cwd=$(pwd)
config="${cwd}/.config"
client_home="/home/${1}"

echo ">>>INSTALLING direnv"
sudo pacman -S direnv

echo ">>>COPYING DOTFILES"
cp -r $cwd/home/* $client_home
# TOOD: copy over non-home dir dots
