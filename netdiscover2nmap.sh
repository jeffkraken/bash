#! /bin/bash

#TO DO: variables for IP Range and find a way to cut "Active" line without using a second cut command

netdiscover -P -N -r 172.20.1.0/24 > local_net
cut -d ' ' -f2 local_net | grep '172.' > hosts
nmap -iL hosts -p 21,135,139,445
