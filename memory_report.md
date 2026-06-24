# Memory Report Generator

## Overview

A simple Bash script that generates a memory usage report and saves it to a file.

## Features

* Displays RAM and swap usage (`free -h`)
* Collects virtual memory statistics (`vmstat`)
* Includes report generation timestamp
* Saves output automatically to a log file

## Requirements

* Linux system
* Bash shell
* `free` and `vmstat` utilities

## Installation

```bash
chmod +x memory_report.sh
```

## Usage

```bash
./memory_report.sh
```

## Output

The report is saved to:

```text
/tmp/memory_report.txt
```

View the report:

```bash
cat /tmp/memory_report.txt
```

## Example Output

```text
=== MEMORY REPORT ===
Generated: Thu Jun 25 10:15:42 IST 2026

               total        used        free
Mem:           7.7Gi       2.5Gi       3.1Gi
Swap:          2.0Gi       0.0Gi       2.0Gi
```

## Author

Guganraj (George)

## Version

1.0

## License

MIT
