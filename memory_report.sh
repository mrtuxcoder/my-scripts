#!/bin/bash

OUTPUT="/tmp/memory_report.txt"

{
echo "=== MEMORY REPORT ==="
echo "Generated: $(date)"
echo

free -h
echo
vmstat 1 5

} > "$OUTPUT"

echo "Report generated: $OUTPUT"