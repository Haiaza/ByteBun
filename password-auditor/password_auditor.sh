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
INPUT_FILE='weak_password_list.txt'
COMMON_PASSWORDS='10k-most-common.txt'
REPORT="password_report_$(date +%s).txt"

# Functions 
# Checking different things in the password
# LVL UP ?? Follow the ( Sep 27, 2023 ) https://www.cisa.gov/secure-our-world/use-strong-passwords recommendations

check_length() {
    awk '{ if (length($0) < 10) print "❌ Too short: " $0 }' $INPUT_FILE
}

check_complexity() {
    grep -E -v '(.*[A-Z].*[!@#$%^&*].*[0-9])' $INPUT_FILE | \
    awk '{ print "⚠️ Weak complexity: " $0 }'
}

check_common() {
    grep -F -f $COMMON_PASSWORDS $INPUT_FILE | \
    awk '{ print "🚨 Common password: " $0 }'
}

# Generate the report
{
    echo '=== Password Audit Report'
    echo "Scan date: $(date)"
    echo '========================='

    echo -e '\n[1] Length Check (<10 chars):'
    check_length

    echo -e '\n[2] Complexity Check (missing upper/special/num):'
    check_complexity

    echo -e '\n[3] Common Password Check:'
    check_common
} > $REPORT

echo "Report Generated: $REPORT"