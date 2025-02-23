#!/bin/bash

# Network Security Scanner
TARGET="127.0.0.1" # setting this to local host
OUTPUT_FILE="security_report_$(date + %Y%m%d%H%M).txt"

echo "(\__/)  
(•ㅅ•)   🥕 Running network security scan...!  
/ 　 づ  
━━━∪━━━━━━  "
echo "Target: $TARGET"
echo "============================="

# Running an nmap scan
nmap_result=$(nmap -T4 -F $TARGET)

# Save the output
echo "$nmap_result" > $OUTPUT_FILE

# Parse the results 
open_ports=$(echo "$nmap_result" | grep 'open' | awk '{print $1}' | cut -d'/' -f1)  
# Checking for 'Open' ports, filtering for the column with the port number,  removing the protocol part of the port.

# Generating the report
echo -e "\nSecurity Report Summary" >> $OUTPUT_FILE # the -e flag enables me to use "e"scape characters like newline
echo "Scan Date: $(date)" >> $OUTPUT_FILE
echo "Scanned IP: $TARGET" >> $OUTPUT_FILE
echo  -e  "\nOpen Ports Detected:" >> $OUTPUT_FILE # here and above they are being used for formatting
echo "$open_ports" >> $OUTPUT_FILE

 # Basic vulnerability check
 echo -e "\nCommon Vulnerabilties to Check:" >> $OUTPUT_FILE
 echo "$open_ports" | while read port; do
    case $port in
        21) echo "FTP (Port 21): Ensure anonymous login is disabled" ;;
        22) echo "SSH (Port 22): Check for weak passwords/outdared versions" ;;
        80 | 443) echo "HTTP(S) (Port $port): Look for outdated web servers" ;;
        3389) echo "RDP (Port 3389): Ensure proper authentication" ;;
        *) echo "Port $port: Research recommended security config for this port" ;;
    esac
done >> $OUTPUT_FILE

echo -e "\nScan complete!  Report saved to $OUTPUT_FILE"