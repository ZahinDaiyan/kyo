#!/bin/bash
# === kyo/scripts/add.sh ===

# Automatically detect root of project (kyo/)
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SNAPSHOT_DIR="$BASE_DIR/snapshots"
LOG_FILE="$BASE_DIR/kyo.log"

# Ensure snapshots folder exists
mkdir -p "$SNAPSHOT_DIR"

# --- Validate input ---
if [ -z "$1" ]; then
    echo "❌ Error: Missing snapshot name."
    echo "Usage: kyo add <name>"
    exit 1
fi

SNAPSHOT_NAME="$1"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
SNAPSHOT_PATH="$SNAPSHOT_DIR/${SNAPSHOT_NAME}_${TIMESTAMP}"

# --- Copy project ---
rsync -a --exclude=".git" --exclude="snapshots" --exclude="kyo.log" --exclude="scripts" "$BASE_DIR/" "$SNAPSHOT_PATH/"

# --- Log operation ---
echo "$(date +"%Y-%m-%d %H:%M:%S") | ADD | $SNAPSHOT_NAME | $SNAPSHOT_PATH" >> "$LOG_FILE"

# --- Notify user ---
echo "✅ Snapshot '$SNAPSHOT_NAME' created successfully."
echo "📁 Saved to: $SNAPSHOT_PATH"

#!/bin/bash

# Parameters:
# $1 = snapshot name
# $2 = snapshot directory path
# $3 = log file path

commit_name="$1"
snapshot_dir="$2"
log_file="$3"

# Validate input
if [ -z "$commit_name" ]; then
  echo "❌ Usage: kyo add <commit-name>"
  exit 1
fi

# Timestamp for unique naming
timestamp=$(date +"%d-%B_%H-%M-%S")
snapshot_name="${commit_name}-${timestamp}"
target_dir="${snapshot_dir}/${snapshot_name}"

# Create snapshot
mkdir -p "$target_dir"
rsync -a --exclude 'snapshots' --exclude '.git' . "$target_dir"

# Log + output
echo "[$(date)] Added snapshot '$snapshot_name' from $(pwd)" >> "$log_file"
echo "✅ Snapshot '$snapshot_name' saved at: $target_dir"
