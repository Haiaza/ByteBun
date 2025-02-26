#!/bin/bash

# Config
SERVICE='apache2'
LOG_FILE='/var/log/apache2/access.log'
REPORT_FILE='security_report_$(date +%Y%m%d%H%M).txt'

echo "   
__________          __           __________              
\______   \___.__._/  |_  ____   \______   \__ __  ____  
 |    |  _<   |  |\   __\/ __ \   |    |  _/  |  \/    \ 
 |    |   \\___  | |  | \  ___/   |    |   \  |  /   |  \
 |______  // ____| |__|  \___  >  |______  /____/|___|  /
        \/ \/                \/          \/           \/ 
 Automated Service Guardian v1.0
" > $REPORT_FILE

# Service Status : Check 1
if systemctl is-active --quiet $SERVICE; then
    echo "[+] Service Status: Running" >> $REPORT_FILE
else
    echo "[-] Service Status: NOT RUNNING!" >> $REPORT_FILE
    systemctl start $SERVICE && echo "Service restarted" >> $REPORT_FILE
fi  # fi denotes the end of 'if' logic code, including the else.

# Open Ports : Check 2
echo -e '\nOpen Ports:' >> $REPORT_FILE
ss -tulpn | grep ':80' >> $REPORT_FILE
# 'tulpn' is a mix of flags  | https://www.geeksforgeeks.org/ss-command-in-linux/
# basically // show me the TCP/UDP/listening/process-associated/numeric-address

# Suspicious log Entries : Check 3
echo -e '\nRecent Suspicious Activity:' >> $REPORT_FILE
tail -n 50 $LOG_FILE | grep -E '\.\./|/etc/passwd/union select' >> $REPORT_FILE
# tail outputs the latest data from a file -n specifies how many lines to look back
# grep -E is targeting Ext.Regular Expressions - these are combating 3 possible attack methods
# In this order , Directory Traversal // Sensitive File Access // (1)SQL Injection

# Outdated Version Alert : Check 4
APACHE_VER=$(apache2 -v | grep -Po '(?<=Apache/)\d+\.\d+\.\d+')
    if [[ $APACHE_VER < '2.4.41' ]]; then
        echo -e '\n[!] SECURITY WARNING: Outdated Apache ($APACHE_VER)' >> $REPORT_FILE
        echo 'Recommended action: sudo apt upgrade apache2' >> $REPORT_FILE
    fi
