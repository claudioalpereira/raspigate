#!/bin/bash
#-------------------------------------------------
#-- Generate server cert to use with mosquitto
#-------------------------------------------------

cd certs
EASYRSA_REQ_CN=mqtt-server ./easyrsa --batch gen-req mqtt-server nopass
./easyrsa sign-req server mqtt-server
cd ..