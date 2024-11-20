#!/bin/bash

# Used to connect to the OTW wargame "Bandit"

# Define the hostname and port
HOST="bandit.labs.overthewire.org"
PORT=2220
read -p "Enter the username..." USER

# Challenge for students
# Can you add something that allows you to pass the password as a part of this script?

# Connect to Bandit
ssh -p $PORT $USER@$HOST
