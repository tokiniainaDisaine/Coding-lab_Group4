#!/bin/bash

# Log file paths
HEART_LOG="hospital_data/active_logs/heart_rate.log"
TEMP_LOG="hospital_data/active_logs/temperature.log"
WATER_LOG="hospital_data/active_logs/water_usage.log"
REPORT_FILE="hospital_data/reports/analysis_report.txt"

# Ensure reports directory exists
mkdir -p "hospital_data/reports" || { echo "Error: Could not create reports directory."; exit 1; }

# Prompt user
echo "Select log file to analyze:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Write to report
#  {
#    echo "-----------------------------"
#    echo "---- Analysis: $(date) ----"
#    echo "Log Type: $log_name"
#    echo "Device Entry Counts:"
#    awk -F ':' '{print $1}' "$log" | sort | uniq -c
#    echo "First Timestamp: $first"
#    echo "Last Timestamp: $last"
#    echo
#  } >> "$report_file"

# Determine selected log file and label
case "$choice" in
    1)
        LOG_FILE="$HEART_LOG"
        LABEL="Heart Rate"
        DEVICE_A="HeartRate_Monitor_A"
        DEVICE_B="HeartRate_Monitor_B"
        ;;
    2)
        LOG_FILE="$TEMP_LOG"
        LABEL="Temperature"
        DEVICE_A="Temp_Recorder_A"
        DEVICE_B="Temp_Recorder_B"
        ;;
    3)
        LOG_FILE="$WATER_LOG"
        LABEL="Water Usage"
        DEVICE_A="Water_Consumption_Meter"
        DEVICE_B=""  # No device B for water usage
        ;;
    *)
        echo "Error: Invalid input. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

echo "Analyzing $LABEL log..."

# Get device counts
DEVICE_COUNTS=$(awk '{print $2}' "$LOG_FILE" | sort | uniq -c)
DEVICE_A_COUNT=$(grep -F "$DEVICE_A" "$LOG_FILE" | wc -l)

if [[ $choice == 3 ]]; then
    DEVICE_B_COUNT="N/A (no device B for water usage)"
else
    DEVICE_B_COUNT=$(grep -F "$DEVICE_B" "$LOG_FILE" | wc -l)
fi

# Ensure log is sorted (if needed)
SORTED_LOG=$(mktemp)
sort "$LOG_FILE" > "$SORTED_LOG"

FIRST_TIMESTAMP=$(head -n 1 "$SORTED_LOG" | awk '{print $1, $2}')
LAST_TIMESTAMP=$(tail -n 1 "$SORTED_LOG" | awk '{print $1, $2}')

# Write final report
{
    echo "======================================"
    echo "Analysis Report - $LABEL Log"
    echo "Date: $(date)"
    echo "--------------------------------------"
    echo "Device Counts:"
    echo "$DEVICE_COUNTS"
    echo ""
    echo "Device A: $DEVICE_A_COUNT"
    echo "Device B: $DEVICE_B_COUNT"
    echo ""
    echo "First Entry: $FIRST_TIMESTAMP"
    echo "Last Entry : $LAST_TIMESTAMP"
    echo "======================================"
    echo ""
} >> "$REPORT_FILE"

rm "$SORTED_LOG"

echo "Analysis complete. Report saved to $REPORT_FILE"

