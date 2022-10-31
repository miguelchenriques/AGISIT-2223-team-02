#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install iputils-ping

# install tools for managing ppa repositories
sudo apt-get -y install software-properties-common
sudo apt-get -y install unzip
sudo apt-get -y install build-essential
# 
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libffi-dev 
# install GNU Privacy Guard
sudo apt-get install -y gnupg
# required for Openstack SDK
sudo apt-get -y install python3-dev 
sudo apt-get -y install python3-pip

# install Ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-add-repository -y -u ppa:ansible/ansible
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install ansible

# Clean up cached packages
sudo apt-get clean all
