# System Health Monitor

## Overview
A lightweight Bash script that monitors essential system resources and provides real-time health reports with color-coded alerts.

## Features
- CPU usage monitoring with threshold alerts
- Memory usage tracking (RAM)
- Disk space utilization for all mounted partitions
- Top 3 CPU-consuming processes
- Load average monitoring
- Color-coded output (red for warnings, green for normal)
- Automatic log file generation
- Health summary with alert count

## Requirements
- Linux system
- Bash shell
- Standard utilities (top, free, df, ps, awk, grep, tee)

## Installation
1. Save the script as `syshealth.sh`
2. Make it executable:
   ```bash
   chmod +x syshealth.sh
   ```

## Configuration
Edit these values at the top of the script:
```bash
DISK_WARNING=80   # Alert if disk usage exceeds 80%
CPU_WARNING=80    # Alert if CPU usage exceeds 80%
MEM_WARNING=80    # Alert if memory usage exceeds 80%
```

## Usage
Run the script:
```bash
./syshealth.sh
```

## Output Sections
1. **System Information**
   - Hostname
   - Current time

2. **CPU Monitoring**
   - Current usage percentage
   - Alert if above threshold
   - Shows top CPU process when high

3. **Memory Monitoring**
   - Used/Total RAM
   - Usage percentage
   - Alert if above threshold
   - Shows top memory process when high

4. **Disk Monitoring**
   - All mounted partitions
   - Usage percentage for each
   - Size information
   - Red alerts for partitions above threshold

5. **Process Information**
   - Top 3 CPU-consuming processes

6. **Load Average**
   - 1, 5, and 15 minute averages

7. **Health Summary**
   - Final system status with alert count

## Log File
Reports are saved to:
```
/tmp/system_health_YYYYMMDD.log
```

## Example Output
```
=== SYSTEM HEALTH REPORT ===
Host: myserver
Time: Mon Feb 19 10:30:45 EST 2024

CPU Usage: 45%
Memory: 2.3G/7.7G (30%)

Disk Usage:
  /: 45% (98G)
  /home: 62% (250G)

Top 3 processes by CPU:
  firefox (25% CPU)
  chrome (12% CPU)
  systemd (2% CPU)
  
Load average: 1.20, 0.85, 0.62

✓ System looks healthy

Log saved to: /tmp/system_health_20240219.log
```

## Alert Colors
- **Red** - Threshold exceeded (⚠)
- **Green** - Normal operation (✓)
- **Yellow** - Issues detected in summary

## Threshold Defaults
| Resource | Warning Level |
|----------|---------------|
| CPU | > 80% |
| Memory | > 80% |
| Disk | > 80% |

## Troubleshooting
| Issue | Solution |
|-------|----------|
| No colors showing | Terminal may not support ANSI colors |
| Permission denied | Run `chmod +x syshealth.sh` |
| "command not found" | Install required utilities |

## Files Accessed
- `/proc/stat` - CPU statistics
- `/proc/meminfo` - Memory information
- `/proc/loadavg` - Load averages

## Author
Guganraj a.k.a George

## Version
1.0

## License
MIT

---
