#!/bin/bash

#################################################################
#        ____       _    ____                                   #
#       |  _ \ ___ | |  / ___| __ _ _ __ ___   ___              #
#       | |_) / _ \| | | |  _ / _` | '_ ` _ \ / _ \             #
#       |  _ < (_) | | | |_| | (_| | | | | | |  __/             #
#       |_| \_\___/|_|  \____|\__,_|_| |_| |_|\___|             #
#                                                               #
#                             Made by                           #
#                                                               #
#                           Mario Sanz                          #
#                       Miguel Ángel Mateos                     #
#                         Alberto Espinosa                      #
#                                                               #
#################################################################
clear

##### VARIABLES #####
movement=5
life=0
attack=0
defense=0
monsters=('Skeleton' 'Goblin' 'Troll')

##### SET LIFE #####
function set_life () {
  for i in $(seq 1 $1); do
    life=$(($life+$RANDOM%6+1))
  done
}

##### MOVEMENT #####
function move () {
  local move=0

  for i in $(seq 1 2)
  do
    move=$(($RANDOM%6+1+$move))
  done
  
  movement=$(($movement-$move))
}

##### SELECT YOUR PLAYER #####
function player () {
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
      defense=4
    ;;

    2)
      echo "You select the ASSASSIN"
      set_life 2
      attack=3
      defense=2
    ;;

    3)
      echo "You select the PARIAH. Get ready to SUFFER!!!"
      set_life 1
      attack=1
      defense=1
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
function dashboard () {
  echo "######################################################"
  echo "#                          |                         #"
  echo "#           Steps          |           Life          #"
  echo "#             $movement           |            $life            #"
  echo "#                          |                         #"
  echo "######################################################"
}

##### THROW DICE #####
function throw_dice () {
  local total=0

  for i in $(seq 1 $1); do
    total=$(($total+$RANDOM%6+1))
  done

  echo $total
}

##### COMBAT #####
function combat () {
  local monster_attack=0
  local monster_defense=0
  local monster_life=1
  local first_defense=1
  local current_attack=0
  local current_monster_attack=0
  local current_defense=0
  local current_monster_defense=0
  local damage=0

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

    3) # Boss
      monster_attack=4
      monster_defense=4
    ;;
  esac

  while [ $monster_life -ne 0 ] && [ $life -gt 0 ]; do
    dashboard
    echo "1) Attack"
    echo "2) Defense"
    
    read -n 1 -s mode

    case $mode in
      1)
        current_attack=$(throw_dice $attack)
        current_monster_defense=$(throw_dice $monster_defense)

        if [ $current_attack -gt $current_monster_defense ]; then
          monster_life=0

          if [ $1 -ne 3 ]; then
            echo "You kill the ${monsters[$1]}."
          else
            echo "You kill Shrek."
          fi
          
        elif [ $current_attack -eq $current_monster_defense ]; then
          echo "It was a tie."
        else 
          current_monster_attack=$(throw_dice $monster_attack)
          current_defense=$(throw_dice $defense)

          damage=$(($current_monster_attack-$current_defense))

          if [ $1 -ne 3 ]; then
            echo "The ${monsters[$1]} defended. Ready to counter."
            sleep 1

            if [ $damage -gt 0 ]; then
              echo "You received $damage damage."
              life=$(($life-$damage))
            else
              echo "You avoid damage."
            fi
          else
            echo "Shrek defended. Ready to counter."

            sleep 1

            if [ $damage -gt 0 ]; then
              echo "You received $damage damage."
              life=$(($life-$damage))
            else
              echo "You avoid damage."
            fi
          fi
        fi

        sleep 1
        clear
      ;;

      2)
        if [ $first_defense -eq 1 ]; then
          defense=$(($defense+1))
          first_defense=0
          echo "You got an extra defense dice"
          sleep 1
        else
          defense=$(($defense-1))
        fi

        echo "Trying to defend."
        sleep 1
        current_monster_attack=$(throw_dice $monster_attack)
        current_defense=$(throw_dice $defense)

        damage=$(($current_monster_attack-$current_defense))

        if [ $damage -gt 0 ]; then
          echo "You get $damage damage."
          life=$(($life-$damage))
        else
          echo "You defended yourself."
        fi
        sleep 1
        clear
      ;;
    esac

    if [ $life -le 0 ]; then
      echo "▓██   ██▓ ▒█████   █    ██    ▓█████▄  ██▓▓█████ ▓█████▄ ";
      echo " ▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▒██▀ ██▌▓██▒▓█   ▀ ▒██▀ ██▌";
      echo "  ▒██ ██░▒██░  ██▒▓██  ▒██░   ░██   █▌▒██▒▒███   ░██   █▌";
      echo "  ░ ▐██▓░▒██   ██░▓▓█  ░██░   ░▓█▄   ▌░██░▒▓█  ▄ ░▓█▄   ▌";
      echo "  ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░▒████▓ ░██░░▒████▒░▒████▓ ";
      echo "   ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒     ▒▒▓  ▒ ░▓  ░░ ▒░ ░ ▒▒▓  ▒ ";
      echo " ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░     ░ ▒  ▒  ▒ ░ ░ ░  ░ ░ ▒  ▒ ";
      echo " ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░     ░ ░  ░  ▒ ░   ░    ░ ░  ░ ";
      echo " ░ ░         ░ ░     ░           ░     ░     ░  ░   ░    ";
      echo " ░ ░                           ░                  ░      ";
      exit 0
    fi
  done

  first_defense=1
}

##### MAIN #####
player

while true; do
  sleep 1
  clear
  dashboard
  read -n 1 -s -p "Press Enter to move..."
  echo
  move
  combat_prob=$(($RANDOM%3))

  if [ $movement -le 0 ]; then
    boss=$(($RANDOM%2))
    movement=0

    if [ $boss -eq 0 ]; then
      echo "Shrek appeared. BE CAREFUL!!"
      sleep 1
      clear
      combat 3
    fi

  elif [ $combat_prob -eq 0 ]; then
    random_monster=$(($RANDOM%3))
    echo "A ${monsters[$random_monster]} has appeared"
    sleep 1
    clear
    combat $random_monster
  fi

  if [ $movement -le 0 ]; then
    echo "You escape from the castle."
    sleep 1
    echo " ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄ "
    echo "▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌"
    echo "▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌"
    echo "▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌"
    echo "▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌       ▐░▌"
    echo "▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌"
    echo " ▀▀▀▀█░█▀▀▀▀ ▐░▌       ▐░▌▐░▌       ▐░▌"
    echo "     ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌"
    echo "     ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌"
    echo "     ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌"
    echo "      ▀       ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ "
    echo "                                       "
    echo " ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄ "
    echo "▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌"
    echo "▐░▌       ▐░▌ ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌     ▐░▌"
    echo "▐░▌       ▐░▌     ▐░▌     ▐░▌▐░▌    ▐░▌"
    echo "▐░▌   ▄   ▐░▌     ▐░▌     ▐░▌ ▐░▌   ▐░▌"
    echo "▐░▌  ▐░▌  ▐░▌     ▐░▌     ▐░▌  ▐░▌  ▐░▌"
    echo "▐░▌ ▐░▌░▌ ▐░▌     ▐░▌     ▐░▌   ▐░▌ ▐░▌"
    echo "▐░▌▐░▌ ▐░▌▐░▌     ▐░▌     ▐░▌    ▐░▌▐░▌"
    echo "▐░▌░▌   ▐░▐░▌ ▄▄▄▄█░█▄▄▄▄ ▐░▌     ▐░▐░▌"
    echo "▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌"
    echo " ▀▀       ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀ "
    echo "                                       "

    exit 0
  elif [ $life -le 0 ]; then
    echo "You died"
    exit 0
  fi
done
