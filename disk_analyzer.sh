#!/bin/bash

# Disk Analyzer Script
# Version: 1.0
#Author: George


if [ "$EUID" -ne 0 ]; then
    echo "This script needs superuser privileges. Run with sudo."
	exit 1
fi

# Simple Disk Status Checker
echo "=================================="
echo "     DISK STATUS REPORT"
echo "=================================="
echo ""

# 1. Basic disk space usage
echo "📁 DISK SPACE USAGE:"
df -h | grep -E "^/dev/|Filesystem"
echo ""

# 2. Mounted filesystems
echo "🔧 MOUNTED FILESYSTEMS:"
mount | grep "^/dev/" | column -t
echo ""

# 3. LVM information (if exists)
if command -v lvs &> /dev/null; then
    echo "📊 LVM PHYSICAL VOLUMES:"
    pvs 2>/dev/null || echo "  No LVM PVs found"
    echo ""
    
    echo "📊 LVM VOLUME GROUPS:"
    vgs 2>/dev/null || echo "  No LVM VGs found"
    echo ""
    
    echo "📊 LVM LOGICAL VOLUMES:"
    lvs 2>/dev/null || echo "  No LVM LVs found"
    echo ""
fi

# 4. Inode usage (important for Linux)
echo "📌 INODE USAGE:"
df -i | grep -E "^/dev/|Filesystem" | head -5
echo ""

# 5. Disk I/O stats (if iostat is available)
if command -v iostat &> /dev/null; then
    echo "⚡ DISK I/O STATISTICS:"
    iostat -x 1 2 | head -20
    echo ""
fi

# 6. Find largest directories in current location
if [ "$1" = "-d" ] || [ "$1" = "--detailed" ]; then
    echo "🔍 LARGEST DIRECTORIES (in current location):"
    du -sh * 2>/dev/null | sort -hr | head -10
    echo ""
fi

echo "=================================="
echo "Report generated: $(date)"
