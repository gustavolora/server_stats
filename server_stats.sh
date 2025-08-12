#!/bin/bash

# This script is focused on give the user a brief visual of the server stats

echo "####################"
echo "### SERVER STATS ###"
echo "####################"
echo
uptime
echo "### SYSTEM VERSION ###"
cat /etc/os-release | grep "VERSION=" 

echo
echo 
# Display CPU usage

echo "### CPU USAGE ###"
echo
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Usage: "100 - $1"%"}'

echo "### MEMORY USAGE ###"
echo 
free -h | awk 'NR==2{printf "Memory Usage: %s/%s (%.2f%%)\n", $3,$2,$3*100/$2 }'

echo "### TOTAL DISK USAGE ###"
echo 

df -h | awk '$NF=="/"{printf "Disk Usage: %d/%d (%s)\n", $3,$2,$5}'
echo "### TOP 5 PROCESSES BY MEMORY USAGE ###"
echo
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "### TOP 5 PROCESSES BY CPU USAGE ###"
echo
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "### NETWORK STATISTICS ###"
echo
if command -v ifstat &> /dev/null; then
    ifstat -S 1 1
else
    echo "ifstat command not found. Install it to see network statistics."
fi

