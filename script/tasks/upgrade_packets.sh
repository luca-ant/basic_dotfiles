#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

WD=$(dirname $(realpath $0))
WD=$(dirname "$WD")
BD=$(dirname "$WD")

source "$WD/utils/check.sh"
source "$WD/utils/os.sh"

check_user

$ECHO_BLUE
echo "[-] RUNNING TASK $0..."
$ECHO_WHITE

if [ $# != 1 ]
then
    usage
    exit 1
fi
if [ $1 != "install" ] && [ $1 != "remove" ]
then
    usage
    exit 2
fi

if [ $1 == "install" ]

then
    update_packets


elif [ $1 == "remove" ]
then

    color_command echo "NOTHING TO DO!"

else
    usage
    exit 3
fi

$ECHO_BLUE
echo "[+] RUNNING TASK $0... DONE!"
$ECHO_RESET

