#!/bin/bash

echo "===================================================="
echo "     NETWORK AUDIT TOOL (OS | PORT | VULN)"
echo "===================================================="

# Detect active interface
INTERFACE=$(ip route | grep default | awk '{print $5}')

if [ -z "$INTERFACE" ]; then
    echo "[!] No active network interface found."
    exit 1
fi

echo "[+] Interface: $INTERFACE"

# Detect network range
NETWORK=$(ip -o -f inet addr show "$INTERFACE" | awk '{print $4}')

if [ -z "$NETWORK" ]; then
    echo "[!] Unable to detect network range."
    exit 1
fi

echo "[+] Network Range: $NETWORK"
echo ""

echo "[*] Discovering live hosts (IP + MAC)..."
echo "----------------------------------------------------"

nmap -sn "$NETWORK" > /tmp/hosts.txt

grep "Nmap scan report" /tmp/hosts.txt
grep "MAC Address" /tmp/hosts.txt

echo ""
echo "[*] Starting deep scan on each host..."
echo "----------------------------------------------------"

# Extract IPs
IPS=$(grep "Nmap scan report" /tmp/hosts.txt | awk '{print $5}')

for ip in $IPS; do
    echo ""
    echo "===================================================="
    echo " Host: $ip"
    echo "===================================================="

    nmap \
    -sS \
    -sU \
    -sV \
    -O \
    --script vuln \
    -Pn \
    "$ip"

done

echo ""
echo "[✔] Network audit completed"
