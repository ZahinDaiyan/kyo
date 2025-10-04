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

