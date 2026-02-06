#!/bin/bash

# User Monitor Script
# Author: George
# Version: 1.0

# Check root access
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script requires root privileges" >&2
    exit 1
fi

# Create output log file
OUTPUT_FILE="/var/log/user_report_$(date '+%Y%m%d_%H%M%S').log"

echo "Generating user report to: $OUTPUT_FILE"

{
echo "=== USER ACCOUNT REPORT ==="
echo "Report generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname: $(hostname)"

echo -e "\n=== SYSTEM STATISTICS ==="
echo "Total Users: $(wc -l < /etc/passwd)"
echo "Logged in Users: $(who | wc -l)"

echo -e "\n=== ALL USERS ==="
cut -d: -f1 /etc/passwd

echo -e "\n=== CURRENTLY LOGGED IN ==="
who

echo -e "\n=== LOCKED USERS ==="
awk -F: '($2 ~ /^(\!|\*)/) {print $1}' /etc/shadow 2>/dev/null | grep . || echo "No locked accounts found"

echo -e "\n=== USERS WITH NO PASSWORD ==="
awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null | grep . || echo "No accounts with empty password"

echo -e "\n=== SUDO USERS ==="
getent group sudo | cut -d: -f4 | tr ',' '\n'

echo -e "\n=== LAST LOGINS ==="
last -n 5

} > "$OUTPUT_FILE" 2>&1

echo "Report completed: $OUTPUT_FILE"
echo "Line Count: $(wc -l < "$OUTPUT_FILE") lines"# Script: user_monitor.sh
# Description: This is a sample user_monitor script
# Created: Friday 06 February 2026 06:15:21 PM IST

echo 'Running user_monitor...'
echo 'Script functionality would go here'

# Add your actual script logic below
