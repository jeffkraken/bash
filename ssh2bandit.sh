#!/bin/bash
# updated 12/6/2025 based on bodydoubling video
# Used to connect to the OTW wargame "Bandit"

# Define the hostname and port
HOST="bandit.labs.overthewire.org"
read -p "Enter the username..." USER

# Connect to Bandit
ssh -p 2220 $USER@$HOST

# For automating, install sshpass (ex. sudo apt install sshpass). 
# Then comment out the ssh line above.
# Then uncomment the following.
#PSWD=$(cat pswd | grep $NAME | awk '{print $3}' | head -n 1)
#sshpass -p $PSWD ssh $USER@$HOUST -p 2220
