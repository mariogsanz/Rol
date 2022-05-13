#!/bin/bash

#################################################################
#        ____       _    ____                                   #
#       |  _ \ ___ | |  / ___| __ _ _ __ ___   ___              #
#       | |_) / _ \| | | |  _ / _` | '_ ` _ \ / _ \             #
#       |  _ < (_) | | | |_| | (_| | | | | | |  __/             #
#       |_| \_\___/|_|  \____|\__,_|_| |_| |_|\___|             #
#                                                               #
#################################################################
clear

##### VARIABLES #####
movement=$(($RANDOM%51+50))
life=0
attack=0
monsters=('Skeleton' 'Goblin' 'Troll')

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
      attack=2
    ;;

    2)
      echo "You select the ASSASSIN"
      set_life 2
      attack=3
    ;;

    3)
      echo "You select the PARIAH. Get ready to SUFFER!!!"
      set_life 1
      attack=1
    ;;

    0)
      exit 0
    ;;

    *)
      echo "Incorrect option."
      player
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

##### ATTACK #####
attack () {
  local attack=0

  for i in $(seq 1 $1); do
    attack=$attack+$i
  done

  echo $attack
}

##### DEFENSE #####
defense () {
  local defense=0

  for i in $(seq 1 $1); do
    defense=$defense+$i
  done

  echo $defense
}

##### COMBAT #####
combat () {
  local monster_attack=0
  local monster_defense=0
  local monster_life=1
  local first_defense=1

  case $1 in
    0) # Skeleton
      monster_attack=1
      monster_defense=1
    ;;

    1) # Goblin
      monster_attack=1
      monster_defense=2
    ;;

    2) # Troll
      monster_attack=3
      monster_defense=2
    ;;
  esac

  while [ $monster_life -ne 0 || $life -ne 0 ]; do
    echo "1) Attack"
    echo "2) Defense"
    
    read -n 1 -s -p mode

    case $mode in
      1)
        local current_attack=$(attack)
      ;;

      2)

      ;;
    esac
  done
}

##### MAIN #####
player

while true; do
  sleep 2
  clear
  dashboard
  read -n 1 -s -p "Press Enter to move..."
  echo
  move
  combat_prob=$(($RANDOM%3))

  if [ $movement -le 0 ]; then
    boss=$(($RANDOM%2))

    if [ $boss -eq 0 ]; then
      echo "Shrek appeared. BE CAREFUL!!"
    fi

  elif [ $combat_prob -eq 0 ]; then
    random_monster=$(($RANDOM%3))
    echo "A ${monsters[$random_monster]} has appeared"
    combat $random_monster
  fi

  if [ $movement -le 0 ]; then
    echo "You escape from the castle. You WIN!!"
    exit 0
  elif [ $life -le 0 ]; then
    echo "You died"
    exit 0
  fi
done
