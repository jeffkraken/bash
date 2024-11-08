#! /bin/bash

iprange=$(ip a | grep 'dynamic' | cut -d ' ' -f6)
octect=$(ip a | grep 'dynamic' | cut -d ' ' -f6 | cut -d '.' -f1)

netdiscover -P -N -r "$iprange" > local_net
cut -d ' ' -f2 local_net | grep "$octect" > hosts
nmap -iL hosts -p 21,135,139,445
