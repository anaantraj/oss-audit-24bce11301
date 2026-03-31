#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Anaant Raj
# Demonstrates: Arrays, for loops, awk data extraction, and formatted printing.

# Dynamically find the local python site-packages if it exists, fallback to standard lib
LOCAL_PY_DIR=$(python3 -m site --user-site 2>/dev/null)
if [ -z "$LOCAL_PY_DIR" ] || [ ! -d "$LOCAL_PY_DIR" ]; then
    LOCAL_PY_DIR="/usr/lib/python3"
fi

# Target directories to audit
DIRS=("/etc" "/var/log" "/home/$(whoami)" "$LOCAL_PY_DIR" "/tmp")

echo "==============================================================="
printf "%-30s | %-10s | %-15s\n" "DIRECTORY PATH" "SIZE" "PERMISSIONS"
echo "==============================================================="

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Suppress errors for directories we don't have read access to
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        # Extract the permissions block and the owner/group
        PERMS=$(ls -ld "$DIR" | awk '{print $1 " (" $3 ")"}')
        
        # Format the output into clean columns
        printf "%-30s | %-10s | %-15s\n" "$DIR" "${SIZE:-N/A}" "$PERMS"
    else
        printf "%-30s | %-10s | %-15s\n" "$DIR" "MISSING" "N/A"
    fi
done
echo "==============================================================="
