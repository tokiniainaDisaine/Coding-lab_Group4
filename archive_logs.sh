#!/bin/bash

read -p "Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): " user_choice

#check if the input is valid

if [[ "user_choice" != "1" && "user_choice" != "2" && "user_choice" != "3" && ]]; then
	echo " Error: The input is wrong, please select 1, 2, and 3."
	exit 1
fi


