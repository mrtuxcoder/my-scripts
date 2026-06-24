# Backup Utility

## Overview

A simple Bash script that creates a compressed backup of a specified directory and stores it in a user-defined destination.

## Features

* Interactive source and destination input
* Validates source directory existence
* Automatically creates backup destination if needed
* Generates timestamped `.tar.gz` archives
* Displays backup status and file location

## Requirements

* Linux system
* Bash shell
* `tar` utility

## Installation

```bash
chmod +x backup.sh
```

## Usage

```bash
./backup.sh
```

Example:

```text
Enter source directory: /home/george/Documents
Enter backup destination: /backup

Backup completed successfully.
Backup file: /backup/Documents_backup_20260624_184512.tar.gz
```

## Output

Backup files are saved as:

```text
<backup_directory>/<folder_name>_backup_YYYYMMDD_HHMMSS.tar.gz
```

Example:

```text
/backup/Documents_backup_20260624_184512.tar.gz
```

## Author

Guganraj (George)

## Version

1.0

## License

MIT
