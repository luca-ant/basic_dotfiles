#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

UBUNTU=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Ubuntu | head -1)
DEBIAN=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Debian | head -1)
RASPBIAN=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Raspbian | head -1)
MANJARO=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Manjaro | head -1)
ARCH=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Arch | head -1)


if [ -z "$DOTFILES_URL" ]
then
    DOTFILES_URL="https://github.com/luca-ant/dotfiles.git"
    # DOTFILES_URL="git@github.com:luca-ant/dotfiles.git"
fi

if [ -z "$DOTFILES_ROOT" ]
then
    DOTFILES_ROOT="/home/$USER/.dotfiles"

#    WD=$(dirname "$(realpath "$0")")
#    WD=$(dirname "$WD")
#    DOTFILES_ROOT="$WD/dotfiles"
fi

if [ -z "$MY_SHELL" ]
then
    MY_SHELL="/home/$USER/.my_shell"
fi

color_command(){
    $ECHO_RED
    $* | while read L; do
        $ECHO_GREEN
        echo $L
        $ECHO_RED
    done
    $ECHO_RESET
}

update_packets(){

    if [ $MANJARO ] || [ $ARCH ]
    then
        color_command sudo pacman --noconfirm -Syu
    fi

    if [ $UBUNTU ] || [ $DEBIAN ] || [ $RASPBIAN ]
    then
        color_command sudo apt update
        color_command sudo apt upgrade -y
    fi
}

install_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then
        color_command sudo pacman --noconfirm -S $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ] || [ $RASPBIAN ]
    then
        color_command sudo apt install -y $*
    fi
}

remove_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then
        color_command sudo pacman --noconfirm -Rs $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ] || [ $RASPBIAN ]
    then
#        color_command sudo apt purge -y $*
        color_command sudo apt remove -y $*
    fi
}

install_aur_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then
        color_command yay --noconfirm -S $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ] || [ $RASPBIAN ]
    then
        color_command echo "AUR is not availabe" 2>&1
    fi
}

remove_aur_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then
        color_command yay --noconfirm -R $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ] || [ $RASPBIAN ]
    then
        color_command echo "AUR is not availabe" 2>&1
    fi
}

install_snap_packet(){

    if [ $MANJARO ] || [ $ARCH ] || [ $RASPBIAN ]
    then
        color_command echo "SNAP is not availabe" 2>&1
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then
        sudo snap install $*
    fi
}

remove_snap_packet(){

    if [ $MANJARO ] || [ $ARCH ] || [ $RASPBIAN ]
    then
        color_command echo "SNAP is not availabe" 2>&1
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then
        sudo snap remove $*
    fi
}

