#!/bin/bash

# Define log file paths
heart_log="hospital_data/active_logs/heart_rate.log"
temp_log="hospital_data/active_logs/temperature.log"
water_log="hospital_data/active_logs/water_usage.log"
report_dir="reports"
report_file="$report_dir/analysis_report.txt"

# Ensure report directory exists
mkdir -p "$report_dir"

# Prompt user
echo "Select log file to analyze:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Determine selected log file
case $choice in
  1)
    log=$heart_log
    log_name="Heart Rate"
    ;;
  2)
    log=$temp_log
    log_name="Temperature"
    ;;
  3)
    log=$water_log
    log_name="Water Usage"
    ;;
  *)
    echo "Invalid input. Please enter 1, 2, or 3."
    exit 1
    ;;
esac

# Validate file existence
if [ ! -f "$log" ]; then
  echo "[!] Log file not found: $log"
  exit 1
fi

# Analysis
echo "Analyzing $log_name log..."

# Get first and last timestamp
first=$(head -n 1 "$log" | awk -F ':' '{print $2}')
last=$(tail -n 1 "$log" | awk -F ':' '{print $2}')

# Write to report
{
  echo "-----------------------------"
  echo "---- Analysis: $(date) ----"
  echo "Log Type: $log_name"
  echo "Device Entry Counts:"
  awk -F ':' '{print $1}' "$log" | sort | uniq -c
  echo "First Timestamp: $first"
  echo "Last Timestamp: $last"
  echo
} >> "$report_file"

echo "Analysis complete. Results saved to $report_file"

