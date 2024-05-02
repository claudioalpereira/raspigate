#!/bin/bash

# Optionally, set default values
# var1="default value for var1"
# var1="default value for var2"

. ./raspigate.config

# PiVPN
sudo apt-get update -y & sudo apt-get upgrade -y

wget https://raw.githubusercontent.com/claudioalpereira/raspigate/main/src/pivpn_options.conf -o pivpn_options.conf
echo pivpnHOST=brunomld.chickenkiller.com >> pivpn_options.conf

curl -L https://install.pivpn.io > pivpn_install.sh
chmod +x pivpn_install.sh
./pivpn_install.sh --unattended pivpn_options.conf

