#!/bin/bash

# Archive directories

HEART_ARCHIVE="hospital_data/archived_logs/heart_data_archives"
TEMP_ARCHIVE="hospital_data/archived_logs/temperature_data_archives"
WATER_ARCHIVE="hospital_data/archived_logs/water_usage_data_archives"

# Active logs

HEART_LOG="hospital_data/active_logs/heart_rate_log.log "
TEMP_LOG="hospital_data/active_logs/temperature_log.log"
WATER_LOG="hospital_data/active_logs/water_usage_log.log"

# Timestamp format

TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')

read -p "Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): " user_choice

#check if the input is valid

if [[ "user_choice" != "1" && "user_choice" != "2" && "user_choice" != "3" ]]; then
	echo " Error: The input is wrong, please select 1, 2, and 3."
	exit 1
fi

# proceed based on the choices

case user_choice in

	

esac
