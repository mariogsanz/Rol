#!/bin/bash

##
#
# ROL
#
##

clear

# Functions

function dashboard(){
	echo "#################################################"
	echo "#	Steps		|	Life		#"
	echo "#-----------------------------------------------#"
	echo "#	$total_steps		|	$total_life		#"
	echo "#################################################"
	echo
}

# Declare variables
let total_steps=50+$(($RANDOM%51))	# Total of steps remaining
let total_life=5+$(($RANDOM%16))	# Total of life remaining

let move_dice	# Array with movement dices

dashboard	# Print dashboard

# Throw dices to move
read -s -n 1 -p "Press any key to throw a dice..."
echo

for i in $(seq 1 2); do
	let move_dice[$i]=$(($RANDOM%6+1))
done

total_steps=$(($total_steps-(${move_dice[1]}+${move_dice[2]})))

echo 
dashboard
