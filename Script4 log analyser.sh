#!/bin/bash
# Script 4: Log File Analyzer
# Author: Anaant Raj
# Demonstrates: Command-line args, while read loops, basic math, regex matching.

# Parameter defaults and assignment
LOGFILE=${1:-"/var/log/syslog"}
KEYWORD=${2:-"error"}

# Validate file exists and is readable
if [ ! -r "$LOGFILE" ]; then
    echo "Error: Cannot read file '$LOGFILE'. Try running with sudo or check path."
    exit 1
fi

echo "Analyzing '$LOGFILE' for pattern: '(?i)$KEYWORD'..."

TOTAL_LINES=0
MATCH_COUNT=0

# Process file line by line safely
while IFS= read -r LINE; do
    TOTAL_LINES=$((TOTAL_LINES + 1))
    
    # -i for case insensitive, -q for quiet (just exit status)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        MATCH_COUNT=$((MATCH_COUNT + 1))
    fi
done < "$LOGFILE"

# Prevent division by zero if file is empty
if [ "$TOTAL_LINES" -gt 0 ]; then
    PERCENT=$(( MATCH_COUNT * 100 / TOTAL_LINES ))
else
    PERCENT=0
fi

echo "--------------------------------------------------"
echo "Scan Complete."
echo "Total lines scanned: $TOTAL_LINES"
echo "Matches found:       $MATCH_COUNT ($PERCENT% of log)"
echo "--------------------------------------------------"

if [ "$MATCH_COUNT" -gt 0 ]; then
    echo "Extracting the 3 most recent occurrences:"
    # Use grep to fetch the actual lines, tail to get the last 3
    grep -i "$KEYWORD" "$LOGFILE" | tail -n 3
fi