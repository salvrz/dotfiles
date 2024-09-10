#! /bin/bash

# ensure admin username provided
echo $#
if [[ $# -lt 1 ]]; then
    echo "Usage: sh install.sh [ADMIN_USERNAME]"
    exit 1
fi

# determine distro
#distro=$(grep -o "ID_LIKE=.*" /etc/os-release | cut -f2- -d=)
distro=$(grep "ID_LIKE=" /etc/os-release)

if echo $distro | grep arch; then ## arch based distros
    echo ">>>LOGGING TO out.txt"
    ./scripts/install.sh "$1" | tee -a out.txt

else  # unsupported distro
    echo $distro
    echo ">>>UNSUPPORTED DISTRO TYPE"
    exit 1
fi

exit 0
