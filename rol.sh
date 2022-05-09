#!/bin/bash

#################################################################
#        ____       _    ____                                   #
#       |  _ \ ___ | |  / ___| __ _ _ __ ___   ___              #
#       | |_) / _ \| | | |  _ / _` | '_ ` _ \ / _ \             #
#       |  _ < (_) | | | |_| | (_| | | | | | |  __/             #
#       |_| \_\___/|_|  \____|\__,_|_| |_| |_|\___|             #
#                                                               #
#################################################################

##### VARIABLES #####
movement=$(($RANDOM%51+50))
life=0

##### MOVEMENT #####
move () {
  for i in $(seq 1 $1)
  do
    let life=$(($life+5)) 
  done
  
}

##### SELECT YOUR PLAYER #####
player () {
  echo " __"
  echo "(_  _ | _  __|_    _    ._ ._ | _.   _ ._"
  echo "__)(/_|(/_(_ |_ \/(_)|_||  |_)|(_|\/(/_|"
  echo "                /          |      /"
  echo
  echo "1) Barbarian"
  echo "2) Assassin"
  echo "3) Pariah (!!! Hardcore Mode !!!)"
  
  read -s -n 1 player
  
  case $player in
    1)
      move 2
    ;;
  esac
  
}

player
