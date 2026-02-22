# 📊 Disk Analyzer

A comprehensive shell script to analyze and report disk status, mounted filesystems, LVM information, and disk I/O statistics on Linux systems.

## 📋 Features

- **Disk Space Usage** - Shows current disk usage for all mounted partitions
- **Mounted Filesystems** - Displays all mounted devices with formatted output
- **LVM Information** - Shows Physical Volumes, Volume Groups, and Logical Volumes (if LVM is used)
- **Inode Usage** - Monitors inode consumption (critical for Linux systems)
- **Disk I/O Statistics** - Real-time disk performance metrics (requires `iostat`)
- **Large Directory Analysis** - Optional detailed view of largest directories

## 🔧 Requirements

- **Root/Sudo Access** - Script requires superuser privileges
- **Optional Tools:**
  - `iostat` - For disk I/O statistics (part of `sysstat` package)
  - LVM tools - For LVM information (usually pre-installed)

## 🚀 Installation

1. **Save the script as `disk_analyzer.sh`**

2. **Make it executable:**
```bash
chmod +x disk_analyzer.sh
```

3. **Move to system path (optional):**
```bash
sudo mv disk_analyzer.sh /usr/local/bin/disk_analyzer
```

## 💻 Usage

### Basic Usage
```bash
sudo ./disk_analyzer.sh
```

### Detailed Mode (shows largest directories)
```bash
sudo ./disk_analyzer.sh --detailed
# or
sudo ./disk_analyzer.sh -d
```

### Example Output
```
==================================
     DISK STATUS REPORT
==================================

📁 DISK SPACE USAGE:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       100G   45G   55G  45% /
/dev/sdb1       500G  200G  300G  40% /data

🔧 MOUNTED FILESYSTEMS:
/dev/sda1 / ext4 rw,relatime 0 0
/dev/sdb1 /data ext4 rw,relatime 0 0

📊 LVM PHYSICAL VOLUMES:
  PV         VG        Fmt  Attr PSize   PFree
  /dev/sdc1  vg_data   lvm2 a--  100.00g 20.00g
```

## 📦 Installation for Required Tools

### Ubuntu/Debian:
```bash
sudo apt update
sudo apt install sysstat lvm2
```

### RHEL/CentOS/Fedora:
```bash
sudo yum install sysstat lvm2
# or for newer versions
sudo dnf install sysstat lvm2
```

## 🔧 Script Configuration

You can modify these default behaviors:

- **Inode display lines**: Change `head -5` to show more/fewer lines
- **I/O stats**: Modify `iostat -x 1 2` for different sampling
- **Large directories**: Change `head -10` to show more/fewer directories

## ⚠️ Important Notes

- **Must be run with sudo/root** - The script checks for EUID 0
- Some features may not work on all Linux distributions
- LVM sections will be skipped if LVM is not installed
- I/O statistics require `iostat` to be installed

## 🐛 Troubleshooting

### "This Script needs SuperUser"
Run the script with sudo:
```bash
sudo ./disk_analyzer.sh
```

### No LVM information showing
LVM tools might not be installed:
```bash
# Check if LVM is installed
which lvs
# Install if missing
sudo apt install lvm2  # Debian/Ubuntu
```

### No I/O statistics
Install sysstat package:
```bash
sudo apt install sysstat
```

## Author
Guganraj a.k.a George

## Version
1.0

## License
MIT

---