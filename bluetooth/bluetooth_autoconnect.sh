#!/bin/bash

if ! command -v /usr/sbin/rfkill &> /dev/null; then
    echo "Error: rfkill command not found. Please install rfkill." >&2
    exit 1
fi

if ! command -v bluetoothctl &> /dev/null; then
    echo "Error: bluetoothctl command not found. Please install bluetoothctl." >&2
    exit 1
fi

#check if bluetooth is enabled
if rfkill list bluetooth |grep -q "Soft blocked: yes"; then
    rfkill unblock bluetooth
fi

if ! rfkill list bluetooth |grep -q "Hard blocked: yes"; then
    sudo systemctl start bluetooth
fi

bluetoothDeviceMacAddress="XX:XX:XX:XX:XX:XX" #put actual mac address here
connectionResult=$(bluetoothctl connect "$bluetoothDeviceMacAddress" | grep "Connection successful")

if [ -n "$connectionResult" ]; then
    echo "Successfully connected to device with MAC address: $bluetoothDeviceMacAddress"
else
    echo "Failed to connect to device with MAC address: $bluetoothDeviceMacAddress"
fi

