#!/bin/bash

#User Monitor Script
#Author: George
set -e
if [[ $EUID -ne O ]]; then
	echo "This script need root privilage"
	exit 1
fi

OUTPUT_FILE="/user_report_$(date '+%Y%m%d').log"

echo "=== USER ACCOUNT REPORT ===" > $OUTPUT_FILE
echo "$(date '+%Y-%m-%d %H%M%S')" >>  $OUTPUT_FILE

TOTAL_USERS=$(wc -l /etc/passwd)

echo "Total Users: $TOTAL_USERS" >> $OUTPUT_FILE
echo "Logged in  Users: $(who | wc -l )" >> $OUTPUT_FILE

echo " " >> $OUTPUT_FILE
echo "=== USERS LIST ===" >> $OUTPUT_FILE
cat /etc/passwd >> $OUTPUT_FILE


echo "===Currently Logged in Users ===" >> $OUTPUT_FILE
echo "$(who)" >> $OUTPUT_FILE


echo "=== USERS without password===" >> $OUTPUT_FILE

echo"$(awk -F: '$2 == "" {print $1}' /etc/shadow)" >> $OUTPUT_FILE

echo "=== USERS with sudo access ===" >> $OUTPUT_FILE
cat /etc/sudoers | grep "ALL=(ALL)" | cut -d$'\t' -f1 >> $OUTPUT_FILE

echo "=== Last 5 Logins ===" >> $OUTPUT_FILE
echo "$(last -n 5)" >> $OUTPUT_FILE








