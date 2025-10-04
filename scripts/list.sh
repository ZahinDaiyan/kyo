#!/bin/bash
# === kyo/scripts/list.sh ===

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SNAPSHOT_DIR="$BASE_DIR/snapshots"

if [ ! -d "$SNAPSHOT_DIR" ]; then
    echo "No snapshots found."
    exit 0
fi

echo "📜 Available snapshots:"
echo "-----------------------"
ls -1 "$SNAPSHOT_DIR" | sort
echo "-----------------------"
echo "Total: $(ls -1 "$SNAPSHOT_DIR" | wc -l)"

