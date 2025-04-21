#!/usr/bin/env bash
# usb_insert_linux.sh - reacts to new USB mounts using udev or polling

mount | grep /dev/sd | grep -v loop | while read -r line; do
  DEV=$(echo "$line" | awk '{print $1}')
  MOUNTPOINT=$(echo "$line" | awk '{print $3}')
  echo "Detected USB: $DEV mounted on $MOUNTPOINT"
  # Optional: verify with fsindex, or ingest
  # ./verify_usb_contents.sh "$MOUNTPOINT"
done
