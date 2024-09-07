#! /bin/zsh

# setup
echo ">>>SETUP..."
cwd=$(pwd)
config="${cwd}/.config"
client_home="/home/${1}"

echo ">>>INSTALLING direnv"
sudo pacman -S direnv

echo ">>>COPYING DOTFILES"
echo "\t...copying ${1}'s home directory"
cp -r $cwd/home/* $client_home
echo "\t...copying root"
sudo cp -r $cwd/root /
