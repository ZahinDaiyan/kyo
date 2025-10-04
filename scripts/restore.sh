#!/bin/bash

# Parameters:
# $1 = commit name (partial snapshot name)
# $2 = snapshot directory path
# $3 = log file path

commit_name="$1"
snapshot_dir="$2"
log_file="$3"

if [ -z "$commit_name" ]; then
    echo "❌ Usage: kyo restore <commit-name>"
    exit 1
fi

# Find all snapshots matching the commit name
matches=($(ls -1 "$snapshot_dir" | grep "^${commit_name}"))

# Check matches
if [ ${#matches[@]} -eq 0 ]; then
    echo "❌ No snapshots found for '$commit_name'"
    exit 1
elif [ ${#matches[@]} -eq 1 ]; then
    snapshot_to_restore="${matches[0]}"
else
    # Multiple matches found — show list for user to choose
    echo "⚠️  Multiple snapshots found for '$commit_name':"
    for i in "${!matches[@]}"; do
        echo "[$i] ${matches[$i]}"
    done

    read -p "Enter the number of the snapshot to restore: " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge ${#matches[@]} ]; then
        echo "❌ Invalid selection."
        exit 1
    fi
    snapshot_to_restore="${matches[$choice]}"
fi

src="${snapshot_dir}/${snapshot_to_restore}"

echo "⚠️  This will overwrite the current directory with snapshot '$snapshot_to_restore'."
read -p "Continue? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Restore
rsync -a --delete "$src/" ./

# Log
echo "[$(date)] Restored snapshot '$snapshot_to_restore' into $(pwd)" >> "$log_file"
echo "✅ Restored snapshot '$snapshot_to_restore' successfully."
