#!/bin/bash

# Network Security Scanner
TARGET="127.0.0.1" # setting this to local host
OUTPUT_FILE="security_report_$(date + %Y%m%d%H%M).txt"

echo "(\__/)  
(•ㅅ•)   🥕 Running network security scan...!  
/ 　 づ  
━━━∪━━━━━━  "
echo "Target: $TARGET"
echo"========================="

# Running an nmap scan
nmap_result=$(nmap -T4 -F $TARGET)

# Save the output
echo "$nmap_result" > $OUTPUT_FILE
