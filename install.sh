#! /bin/bash

# ensure admin username provided
echo $#
if [[ $# -lt 1 ]]; then
  echo "Usage: sh install.sh [ADMIN_USERNAME] <Optional: github email, first name, last name (not required for github config)>"
  exit 1
fi

# determine distro
#distro=$(grep -o "ID_LIKE=.*" /etc/os-release | cut -f2- -d=)
distro=$(grep "ID_LIKE=" /etc/os-release)

if echo $distro | grep arch; then ## arch based distros
  echo ">>>ARCH-BASED DISTRO"
  ./config_scripts/arch_install.sh "$1"

else  # unsupported distro
  echo $distro
  echo ">>>UNSUPPORTED DISTRO TYPE"
  exit 1
fi


if [[ $# -eq 2 ]]; then
  echo "Only provided github email, first name not included"
  echo "Usage: sh install.sh [ADMIN_USERNAME] <Optional: github email, first name, last name (not required for github config)>"
  exit 0

else if [[ $# -eq 3 ]]; then
  sh ./config_scripts/git_config.sh "$2" "$3"
  exit 0

else if [[ $# -eq 4 ]]; then
  name="${3} ${4}"
  sh ./config_scripts/git_config.sh "$2" "$name"
  exit 0

else
  echo "Usage: sh install.sh [ADMIN_USERNAME] <Optional: github email, first name, last name (not required for github config)>"
  exit 1

fi

exit 0
