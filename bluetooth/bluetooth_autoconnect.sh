#!/bin/bash

rfkill unblock bluetooth #power on bluetooth if not turned on
bluetoothctl connect "device_mac_address"

