#!/bin/bash

# Parameters:
# $1 = snapshot name
# $2 = snapshot directory path
# $3 = log file path

snapshot_name="$1"
snapshot_dir="$2"
log_file="$3"

if [ -z "$snapshot_name" ]; then
  echo "❌ Usage: kyo restore <snapshot-name>"
  exit 1
fi

src="${snapshot_dir}/${snapshot_name}"

if [ ! -d "$src" ]; then
  echo "❌ Snapshot '$snapshot_name' not found in $snapshot_dir"
  exit 1
fi

echo "⚠️  This will overwrite the current directory with snapshot '$snapshot_name'."
read -p "Continue? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

rsync -a --delete "$src/" ./
echo "[$(date)] Restored snapshot '$snapshot_name' into $(pwd)" >> "$log_file"
echo "✅ Restored snapshot '$snapshot_name' successfully."
`:w
`