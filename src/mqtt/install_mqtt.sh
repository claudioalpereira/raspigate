#!/bin/bash

# install mosquitto
sudo apt install -y mosquitto mosquitto-clients

# Attention: This will configure mosquitto with certificate on port 8883
#            Mosquitto will fail to start if the files do not exist
cp ./my_mosquitto.conf /etc/mosquitto/conf.d/

sudo systemctl restart mosquitto
