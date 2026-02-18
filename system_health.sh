#!/bin/bash

# System Health Monitor
# Usage: ./syshealth.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'  
NC='\033[0m'

DISK_WARNING=80
CPU_WARNING=80
MEM_WARNING=80
LOG_FILE="/tmp/system_health_$(date +%Y%m%d).log"


log() {
    printf "%b\n" "$1" | tee -a "$LOG_FILE"
}


log "${BLUE}=== SYSTEM HEALTH REPORT ===${NC}"
log "Host: $(hostname)"
log "Time: $(date)"
log ""

# CPU
CPU=$(top -bn1 | grep '%Cpu' | awk '{print $2}')
CPU_INT=$(printf "%.0f" "$CPU" 2>/dev/null || echo "0")

if [ "$CPU_INT" -gt "$CPU_WARNING" ] 2>/dev/null; then
    log "${RED}CPU Usage: ${CPU}% ⚠${NC}"
    log "${RED}Top CPU process:${NC}"
    ps aux --sort=-%cpu | head -2 | tail -1 | awk '{print "  " $11 " (" $3 "%)"}' | while read line; do log "$line"; done
else
    log "${GREEN}CPU Usage: ${CPU}%${NC}"
fi

# Load average
LOAD=$(uptime | awk -F'load average:' '{print $2}')
log "Load average:$LOAD"
log ""

# Memory
MEM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
MEM_USED=$(free -h | grep Mem | awk '{print $3}')
MEM_PERCENT=$(free | grep Mem | awk '{printf "%.0f", ($3/$2)*100}')

if [ "$MEM_PERCENT" -gt "$MEM_WARNING" ] 2>/dev/null; then
    log "${RED}Memory: ${MEM_USED}/${MEM_TOTAL} (${MEM_PERCENT}%) ⚠${NC}"
    log "${RED}Top memory process:${NC}"
    ps aux --sort=-%mem | head -2 | tail -1 | awk '{print "  " $11 " (" $4 "%)"}' | while read line; do log "$line"; done
else
    log "${GREEN}Memory: ${MEM_USED}/${MEM_TOTAL} (${MEM_PERCENT}%)${NC}"
fi
log ""

# Disk
log "${BLUE}Disk Usage:${NC}"
df -h | grep '^/dev/' | while read line; do
    USAGE=$(echo $line | awk '{print $5}' | sed 's/%//')
    MOUNT=$(echo $line | awk '{print $6}')
    SIZE=$(echo $line | awk '{print $2}')
    
    if [ "$USAGE" -gt "$DISK_WARNING" ] 2>/dev/null; then
        log "${RED}  ⚠ $MOUNT: ${USAGE}% full (${SIZE})${NC}"
    else
        log "${GREEN}  ✓ $MOUNT: ${USAGE}% (${SIZE})${NC}"
    fi
done
log ""

# Top processes
log "${BLUE}Top 3 processes by CPU:${NC}"
ps aux --sort=-%cpu | head -4 | tail -3 | awk '{print "  " $11 " (" $3 "% CPU)"}' | while read line; do log "$line"; done
log ""

# Final check
log "${BLUE}Health Summary:${NC}"
if [ "$MEM_PERCENT" -gt "$MEM_WARNING" ] || [ "$CPU_INT" -gt "$CPU_WARNING" ]; then
    log "${YELLOW}  ⚠ Some issues detected${NC}"
else
    log "${GREEN}  ✓ System looks healthy${NC}"
fi

log ""
log "Log saved to: $LOG_FILE"