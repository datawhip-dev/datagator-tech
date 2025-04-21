#!/usr/bin/env bash
# fswatch_macos.sh - uses fswatch for macOS

WATCH_DIR="$1"
fswatch -0 "$WATCH_DIR" | while IFS= read -r -d "" file; do
  echo "Changed: $file"
done
