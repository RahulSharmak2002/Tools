#!/bin/bash

echo "=============================="
echo "     SYSTEM HEALTH REPORT     "
echo "=============================="
echo "Date & Time : $(date)"
echo

# CPU Load
echo "CPU Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo

# Memory Usage
echo "Memory Usage:"
free -h
echo

# Disk Usage
echo "Disk Usage:"
df -h /
echo

# Uptime
echo "System Uptime:"
uptime -p
echo

# Logged in users
echo "Logged In Users:"
who
echo

echo "=============================="
echo "     HEALTH CHECK DONE        "
echo "=============================="
