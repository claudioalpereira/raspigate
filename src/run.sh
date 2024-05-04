#!/bin/bash

# Before running this, there are two steps you need to do:
#    1. Setup a static IP for the raspberry. (I recommend you do that on your router/DHCP server and leave the raspberry DHCP enabled)
#    2. Create a custom subdomain. This example uses a subdomain from freedns.afraid.org 

# Variables you should get 
custom_domain="brunomld.chickenkiller.com"
ddns_cron="4,9,14,19,24,29,34,39,44,49,54,59 * * * * sleep 35 ; wget --no-check-certificate -O - https://freedns.afraid.org/dynamic/update.php?aFROdDhSeU5oUWF3VHBsxptoYkdBYnY6MjAwOTE5OTU= >> /tmp/freedns_brunomld_chickenkiller_com.log 2>&1 &"

# update
sudo apt-get update -y & sudo apt-get upgrade -y

# fetching installation files
sudo apt-get install -y git
git clone https://github.com/claudioalpereira/raspigate.git
sudo chmod -R -x ./raspigate

#./raspigate/src/http/install_http_server.sh


cd ./raspigate/src/ddns
./setup_ddns.sh "$ddns_cron"
cd ../../../

cd ./raspigate/src/mqtt
./install_mqtt.sh
cd ../../../

# server_cert_config.cnf still has hardcoded values, but this will be gone in a future commit anyway
cd ./raspigate/src/certs/
./create_ca_cert.sh
./create_server_cert.sh
./create_client_cert.sh
cd ../../../

cd ./raspigate/src/vpn
echo "pivpnHOST=${custom_domain}" > ./pivpn_options.conf
./create_vpn.sh
cd ../../../
