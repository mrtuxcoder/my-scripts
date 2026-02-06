#!/bin/bash

#User Monitor Script
#Author: George
#check root access
set -e
if [[ $EUID -ne 0 ]]; then
	echo "This script need root privilage"
	exit 1
fi
#create output log file
OUTPUT_FILE="/var/log/user_report_$(date '+%Y%m%d').log"

echo "=== USER ACCOUNT REPORT ===" > $OUTPUT_FILE
echo $(date '+%Y-%m-%d %H%M%S') >>  $OUTPUT_FILE
#print  total user count
TOTAL_USERS=$(wc -l < /etc/passwd)

echo "Total Users: $TOTAL_USERS" >> $OUTPUT_FILE
#print logged users
echo "Logged in  Users: $(who | wc -l )" >> $OUTPUT_FILE

echo "=== USERS LIST ===" >> $OUTPUT_FILE
#print all user list
cut -d: -f1 /etc/passwd >> $OUTPUT_FILE


echo "===Currently Logged in Users ===" >> $OUTPUT_FILE
#print currently logged in users
who >> $OUTPUT_FILE


echo "=== USERS without password===" >> $OUTPUT_FILE
#print users without password
awk -F: '$2 !~ /^[!*]/ && $2 != "" {print $1}' /etc/shadow >> $OUTPUT_FILE

echo "=== USERS with sudo access ===" >> $OUTPUT_FILE
#print users with sudo access
getent group sudo >> $OUTPUT_FILE

echo "=== Last 5 Logins ===" >> $OUTPUT_FILE
#print last 5 login entry
last -n 5 >> $OUTPUT_FILE








