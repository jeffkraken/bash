#! /bin/bash
#This script is to be used for configuring AdGuard Home on Rocky Linux as a part of a guided demo.
#The configs in this script are base/generic, do not use on a live machine.
#If used, be sure to go back and update the rules to block unnecessary traffic.
#Download to VM with the following commmand:
#wget https://raw.githubusercontent.com/jeffkraken/bash/refs/heads/main/fwrules.sh
#After downloading, edit the permissions so that your user can run the script... then run the script.

ipadd=$(ip -4 a | grep 'dynamic' | cut -d ' ' -f6)
echo "Detected IP: $ipadd"
firewall-cmd --new-zone=adguard --permanent
firewall-cmd --zone=adguard --add-source=$ipadd --permanent
firewall-cmd --zone=adguard --add-port=3000/tcp --permanent
firewall-cmd --zone=adguard --add-port=443/tcp --permanent
firewall-cmd --zone=adguard --add-port=53/udp --permanent
firewall-cmd --zone=adguard --add-port=80/tcp --permanent
firewall-cmd --zone=adguard --add-port=22/tcp --permanent
firewall-cmd --reload
echo "AdGuard Firewall Rules applied"
