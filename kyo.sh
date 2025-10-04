#!/bin/bash

# ===============================
#  Kyo - Simple Version Control
# ===============================

BASE_DIR="$HOME/kyo"
SCRIPTS_DIR="$BASE_DIR/scripts"
SNAPSHOT_DIR="$BASE_DIR/snapshots"
LOG_FILE="$BASE_DIR/kyo.log"

# Ensure directories exist
mkdir -p "$SCRIPTS_DIR" "$SNAPSHOT_DIR"
touch "$LOG_FILE"

case "$1" in
  add)
    shift
    "$SCRIPTS_DIR/add.sh" "$@" "$SNAPSHOT_DIR" "$LOG_FILE"
    ;;
  list)
    "$SCRIPTS_DIR/list.sh" "$SNAPSHOT_DIR" "$LOG_FILE"
    ;;
  restore)
    shift
    "$SCRIPTS_DIR/restore.sh" "$@" "$SNAPSHOT_DIR" "$LOG_FILE"
    ;;
  *)
    echo "Usage: kyo {add <name> | list | restore <snapshot-name>}"
    ;;
esac
