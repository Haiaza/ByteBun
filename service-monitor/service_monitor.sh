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