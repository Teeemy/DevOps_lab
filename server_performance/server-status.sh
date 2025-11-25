#!/bin/bash
# Server Performance Monitoring Script
# Analyzes basic server performance stats including:
# - Total CPU usage
# - Total memory usage (Free vs Used including percentage)
# - Total disk usage (Free vs Used including percentage)
# - Top 5 processes by CPU usage
# - Top 5 processes by memory usage

echo "==============================="
echo "Server Status Report"
echo "==============================="

echo "CPU usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 ", System: " $4 ", Idle: " $8}'

echo "Memory usage:" 
free -h | awk 'NR==2 {printf "Total: %s | Used: %s (%s) | Free: %s\n", $2, $3, int($3/$2*100)"%", $4}'

echo "Disk usage:" 
df -h / | awk  'NR==2 {print $5}' | tr -d '%'

echo "Top 5 processes by CPU:" 
ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "%-8s %-6s%% %s\n", $1, $3, $11}'

echo "Top 5 processes by memory:" 
ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "%-8s %-6s%% %s\n", $1, $4, $11}'
