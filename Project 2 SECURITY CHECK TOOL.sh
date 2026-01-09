#!/bin/bash

clear
echo "================================================="
echo "        🔐 CYBERGUARD - SECURITY CHECK TOOL       "
echo "================================================="

# 1️ Logged-in Users
echo "👥 Logged-in Users:"
who
echo "-------------------------------------------------"

# 2️ Failed Login Attempts
echo "🚨 Failed Login Attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 || \
echo "Access denied (Run as root)"
echo "-------------------------------------------------"

# 3️ Open Ports
echo "🌐 Open Ports:"
ss -tuln | head -10
echo "-------------------------------------------------"

# 4️ Firewall Status
echo "🔥 Firewall Status:"
if command -v ufw &> /dev/null; then
    ufw status
else
    echo "Firewall tool not found"
fi
echo "-------------------------------------------------"

# 5️ Suspicious Processes (High CPU)
echo "⚠️  High CPU Processes:"
ps -eo pid,user,comm,%cpu --sort=-%cpu | head -5
echo "-------------------------------------------------"

# 6️ World Writable Files
echo "📂 World Writable Files (Top 5):"
find / -xdev -type f -perm -0002 2>/dev/null | head -5
echo "-------------------------------------------------"

# 7️ Internet Status
echo "🌍 Internet Status:"
ping -c 1 google.com &>/dev/null && echo "Online ✅" || echo "Offline ❌"

echo "================================================="
echo "       ✅ SECURITY SCAN COMPLETED                "
echo "================================================="
