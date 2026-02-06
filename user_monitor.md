# User Monitoring Script

## Overview
A Bash script that generates comprehensive user account reports for Linux systems. This tool is designed for system administrators to monitor user activity, permissions, and security settings.

## Features
- User account enumeration and statistics
- Login activity monitoring
- Password security checks
- Sudo privilege reporting
- Automated log generation with timestamps

## Requirements
- Linux/Unix system
- Bash shell
- Root/sudo privileges
- Standard system utilities (who, awk, cut, etc.)

## Installation
1. Save the script as `user_monitor.sh`
2. Make it executable:
   ```bash
   chmod +x user_monitor.sh
   ```
3. Move to a directory in your PATH (optional):
   ```bash
   sudo mv user_monitor.sh /usr/local/bin/
   ```

## Usage
Run the script with root privileges:
```bash
sudo ./user_monitor.sh
```

Or if installed system-wide:
```bash
sudo user_monitor.sh
```

## Output
The script generates a report file in `/var/log/` with the following format:
```
user_report_YYYYMMDD_HHMMSS.log
```

### Report Contents
1. **System Information**
   - Report generation timestamp
   - Hostname

2. **User Statistics**
   - Total number of user accounts
   - Currently logged-in users count

3. **User Details**
   - Complete list of all system users
   - Currently logged-in users with session details

4. **Security Information**
   - Users with no password set
   - Users with locked accounts
   - Members of sudo group

5. **Login History**
   - Last 5 login records

## Log File Location
Reports are stored in: `/var/log/user_report_*.log`

## Security Notes
- Requires root privileges to access `/etc/shadow` and other protected files
- Log files contain sensitive information - protect accordingly
- Consider setting appropriate permissions on generated logs
- Review `getent group sudo` output as group name may vary by distribution

## Error Handling
- Verifies root privileges before execution
- Handles missing `/etc/shadow` file gracefully
- Captures both stdout and stderr to log file

## Customization
Modify the script to:
- Change log file location
- Adjust number of login records displayed
- Add additional user groups to check
- Include more detailed user information

## Automation
Schedule with cron for regular monitoring:
```bash
# Run daily at 2 AM
0 2 * * * root /path/to/user_monitor.sh
```

## Troubleshooting
- **Permission denied**: Run with sudo or as root
- **Empty sudo users list**: Check if sudo group has different name on your system
- **No output in log**: Verify script has execute permissions

## Files Accessed
- `/etc/passwd` - User account information
- `/etc/shadow` - Password information
- `/var/log/wtmp` - Login records (via `last` command)

## Author
George - System Administrator

## Version
1.1

## License
Open source - free for personal and professional use

## Best Practices
1. Review reports regularly for security audits
2. Archive old logs periodically
3. Monitor for unusual user activity
4. Keep script updated with system changes
5. Test in non-production environments first

---
*Note: This script is intended for authorized system administration purposes only.*