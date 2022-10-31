#!/usr/bin/env bash
# configure hosts file for the internal network
cat >> /etc/hosts <<EOL
# Vagrant environment nodes
192.168.56.20 mgmt 
192.168.56.11 balancer 
192.168.56.31 web1 
192.168.56.32 web2 
192.168.56.33 web3
192.168.56.34 web4 
192.168.56.35 web5 
192.168.56.36 web6 
192.168.56.37 web7 
192.168.56.38 web8
192.168.56.39 web9
EOL