#!/usr/bin/env bash
# verify_usb_contents.sh - checks if USB contents already exist in dedup DB

MOUNTPOINT="$1"
find "$MOUNTPOINT" -type f | while read -r file; do
  sha256=$(sha256sum "$file" | awk '{print $1}')
  echo "Checking $file ($sha256)"
  # Check DB via psql, or local manifest
done
