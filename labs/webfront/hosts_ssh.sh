#!/usr/bin/env bash

# Only allow key based logins
# Matches whitespace characters (spaces and tabs). 
# Newlines embedded in the pattern/hold spaces will also match:
# (#PasswordAuthentication yes)
# (PasswordAuthentication yes)
# (PasswordAuthentication no)

sudo sed -i 's/^\s*#\?PasswordAuthentication\s*\(yes\|no\)\s*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd