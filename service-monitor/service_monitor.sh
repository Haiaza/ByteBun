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