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

##### SET LIFE #####
set_life () {
  for i in $(seq 1 $1); do
    life=$(($life+$RANDOM%6+1))
  done
}

##### MOVEMENT #####
move () {
  local move=0

  for i in $(seq 1 2)
  do
    move=$(($RANDOM%6+1+$move))
  done
  
  movement=$(($movement-$move))
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
  echo "0) ----- EXIT -----"

  read -s -n 1 player
  
  case $player in
    1)
      echo "You select the BARBARIAN"
      set_life 4
    ;;

    2)
      echo "You select the ASSASSIN"
      set_life 2
    ;;

    3)
      echo "You select the PARIAH. Get ready to SUFFER!!!"
      set_life 1
    ;;

    0)
      exit 0
    ;;

    *)
      
    ;;
  esac
  
}

##### DASHBOARD #####
dashboard () {
  echo "######################################################"
  echo "#                          |                         #"
  echo "#           Steps          |           Life          #"
  echo "#             $movement           |            $life            #"
  echo "#                          |                         #"
  echo "######################################################"
}

player

while true; do
  dashboard
  sleep 1
done
