#! /bin/bash

echo ">>>CONFIGURING git credentials"
git config --global user.name $2
git config --global user.email $1
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret