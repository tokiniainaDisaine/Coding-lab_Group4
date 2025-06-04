#!/bin/bash

# Define log file paths

HEART_LOG="hospital_data/active_logs/heart_rate_log.log"
TEMP_LOG="hospital_data/active_logs/temperature_log.log"
WATER_LOG="hospital_data/active_logs/water_usage_log.log"

# Define report file

REPORT_FILE="hospital_data/reports/analysis_report.txt"

# Create reports directory if missing
if [[ ! -d "hospital_data/reports" ]]; then
    mkdir -p "hospital_data/reports" || { echo "Error: Could not create reports directory."; exit 1; }

fi

read -p "Select log to analyze: 
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): " user_choice # Prompt for the user input

# Determine selected log file and label
case "$user_choice" in
    1)
        LOG_FILE="$HEART_LOG"
        LABEL="Heart Rate"
        ;;
    2)
        LOG_FILE="$TEMP_LOG"
        LABEL="Temperature"
        ;;
    3)
        LOG_FILE="$WATER_LOG"
        LABEL="Water Usage"
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

# Start analysis
echo "Analyzing $LABEL log..."

# Count occurrences per device
DEVICE_COUNTS=$(awk '{print $2}' "$LOG_FILE" | sort | uniq -c)

# Get first and last timestamp
FIRST_TIMESTAMP=$(head -n 1 "$LOG_FILE" | awk '{print $1, $2}')
LAST_TIMESTAMP=$(tail -n 1 "$LOG_FILE" | awk '{print $1, $2}')

# Prepare output
{
    echo "Analysis Report - $LABEL Log"
    echo "Date: $(date)"
    echo "--------------------------------------"
    echo "Device Counts:"
    echo "$DEVICE_COUNTS"
    echo "First Entry: $FIRST_TIMESTAMP"
    echo "Last Entry : $LAST_TIMESTAMP"
    echo "======================================"
    echo ""
} >> "$REPORT_FILE"

echo "Analysis complete. Report saved to $REPORT_FILE"
