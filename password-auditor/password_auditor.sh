#!/usr/bin/env bash

# Passwords to test (weak_password_list.txt)
echo "password123
summer2023
Admin#2024
qwerty
SecurePass!2024" > weak_password_list.txt

# Common passwords list (common_passwords.txt)
curl -sO https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt

#Configuration
INPUT_FILE='weak_password.txt'
COMMON_PASSWORDS='10k-most-common.txt'
REPORT='password_report_$(date + %s)'