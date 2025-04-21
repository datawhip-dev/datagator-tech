#!/usr/bin/env bash
# fswatch_linux.sh - uses inotify to watch for filesystem changes

WATCH_DIR="$1"
inotifywait -m -r -e create,modify,delete --format '%w%f %e' "$WATCH_DIR"
