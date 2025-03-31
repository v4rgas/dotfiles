#!/bin/bash

# Get the device ID of "AT Translated Set 2 keyboard"
DEVICE_ID=$(xinput list | grep -i 'AT Translated Set 2 keyboard' | awk -F'id=' '{print $2}' | awk '{print $1}')

if [ -n "$DEVICE_ID" ]; then
  if xinput list-props $DEVICE_ID | grep "Device Enabled (.*):.*1" >/dev/null; then
    xinput disable $DEVICE_ID
    echo "AT Translated Set 2 keyboard (ID: $DEVICE_ID) disabled"
  else
    xinput enable $DEVICE_ID
    echo "AT Translated Set 2 keyboard (ID: $DEVICE_ID) enabled"
  fi
else
  echo "AT Translated Set 2 keyboard not found"
fi
