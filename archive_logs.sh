#!/bin/bash

# Define active log paths
heart_log="hospital_data/active_logs/heart_rate.log"
temp_log="hospital_data/active_logs/temperature.log"
water_log="hospital_data/active_logs/water_usage.log"

# Define archive directories
heart_archive="hospital_data/archived_logs/heart_data_archives"
temp_archive="hospital_data/archived_logs/temperature_data_archives"
water_archive="hospital_data/archived_logs/water_usage_data_archives"

# Prompt user
echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Determine selected log and archive folder
case $choice in
  1)
    log=$heart_log
    archive=$heart_archive
    prefix="heart_rate"
    ;;
  2)
    log=$temp_log
    archive=$temp_archive
    prefix="temperature"
    ;;
  3)
    log=$water_log
    archive=$water_archive
    prefix="water_usage"
    ;;
  *)
    echo "Invalid input. Please enter 1, 2, or 3."
    exit 1
    ;;
esac

# Validate log file
if [ ! -f "$log" ]; then
  echo "[!] Log file not found: $log"
  exit 1
fi

# Create timestamp and archive filename
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
archived_file="$archive/${prefix}_$timestamp.log"

# Archive the file
mv "$log" "$archived_file"
if [ $? -ne 0 ]; then
  echo "[!] Failed to archive log."
  exit 1
fi

touch "$log"
echo "Successfully archived to $archived_file"
