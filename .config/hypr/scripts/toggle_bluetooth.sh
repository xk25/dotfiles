#!/bin/bash

bt_on=$(bluetoothctl show | grep Powered | awk '{print $NF}')

if [ "$bt_on" = "no" ]; then
  echo "Bluetooth is off! Turning on bluetooth..."
  bluetoothctl power on
else
  echo "Bluetooth is on! Turning off bluetooth..."
  bluetoothctl power off
  exit 0
fi
