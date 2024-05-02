#!/bin/bash

# Uses PiVPN to configure a wireguard VPN
#sudo apt-get update -y & sudo apt-get upgrade -y

curl -L https://install.pivpn.io > pivpn_install.sh
chmod +x pivpn_install.sh
./pivpn_install.sh --unattended pivpn_options.conf
