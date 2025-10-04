#!/bin/bash

# Parameters:
# $1 = snapshot directory path
# $2 = log file path

snapshot_dir="$1"
log_file="$2"

echo "📦 Available snapshots:"
ls -1 "$snapshot_dir" | sort

echo "[$(date)] Listed snapshots" >> "$log_file"
