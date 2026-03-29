#!/bin/bash
#Script 4: Log File Analyzer
#Author: HASANUL BENNA
#Course: Open Source Software
#Usage: ./script4.sh /var/log/syslog [keyword]

LOGFILE=$1

KEYWORD=${2:-"error"}
COUNT=0


while [ ! -s "$LOGFILE" ]; do
    echo "Error: File '$LOGFILE' not found or is empty."
    read -p "Please enter a valid log file path to analyze: " LOGFILE
done

echo "Analyzing $LOGFILE for keyword: '$KEYWORD'..."


while IFS= read -r LINE; do
    # -i makes grep case-insensitive (matches ERROR, error, Error)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

echo "---------------------------------------------------"
echo "Keyword '$KEYWORD' found $COUNT times in $LOGFILE"
echo "---------------------------------------------------"

# TODO: print the last 5 matching lines
if [ $COUNT -gt 0 ]; then
    echo "Last 5 occurrences:"
    grep -i "$KEYWORD" "$LOGFILE" | tail -n 5
fi
