#!/bin/bash
# Mac Health Check v1
# Read-only: reports system status and changes nothing.

echo "===== Mac Health Check ====="
echo "Run on: $(date)"
echo ""

echo "--- System ---"
echo "macOS:  $(sw_vers -productVersion) (build $(sw_vers -buildVersion))"

HW=$(system_profiler SPHardwareDataType 2>/dev/null)
echo "Model:  $(echo "$HW" | awk -F': ' '/Model Name/ {print $2}')"
echo "Chip:   $(echo "$HW" | awk -F': ' '/Chip/ {print $2}')"
echo "Memory: $(echo "$HW" | awk -F': ' '/Memory/ {print $2}')"

echo "Uptime: $(uptime | awk -F'up |, [0-9]+ user' '{print $2}')"

echo ""
echo "--- Storage ---"
echo "Disk:   $(df -h / | awk 'NR==2 {print $4 " free of " $2}')"

echo ""
echo "--- Security ---"
echo "FileVault: $(fdesetup status | awk 'NR==1 {print $3}' | tr -d '.')"
echo "Firewall:  $(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | awk '{print $3}' | tr -d '.')"

echo ""
echo "--- Battery ---"
PWR=$(system_profiler SPPowerDataType 2>/dev/null)
if echo "$PWR" | grep -q "Cycle Count"; then
  echo "Cycles:       $(echo "$PWR" | awk -F': ' '/Cycle Count/ {print $2}')"
  echo "Condition:    $(echo "$PWR" | awk -F': ' '/Condition/ {print $2}')"
  echo "Max capacity: $(echo "$PWR" | awk -F': ' '/Maximum Capacity/ {print $2}')"
else
  echo "No battery found (desktop Mac)"
fi

echo ""
echo "===== Done ====="


