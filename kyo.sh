#!/bin/bash

# ===============================
#  Kyo - Simple Version Control
# ===============================

# 1 Detect OS
OS_TYPE="$(uname -s)"

case "$OS_TYPE" in
    Linux*)   
        OS="Linux"
        ;;
    Darwin*)  
        OS="macOS"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        OS="Windows"
        ;;
    *)
        OS="Unknown"
        ;;
esac

# 2 Warn Windows users
if [ "$OS" = "Windows" ]; then
    echo "❌ WARNING: Windows detected. Kyo requires WSL, Git Bash with rsync, or Cygwin to work."
    echo "Please use Linux/macOS or set up WSL/Git Bash before running Kyo."
    exit 1
fi

# 3 Base directories
BASE_DIR="$HOME/kyo"
SCRIPTS_DIR="$BASE_DIR/scripts"
SNAPSHOT_DIR="$BASE_DIR/snapshots"
LOG_FILE="$BASE_DIR/kyo.log"

# 4 Ensure directories exist
mkdir -p "$SCRIPTS_DIR" "$SNAPSHOT_DIR"
touch "$LOG_FILE"

# 5 Command routing
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
