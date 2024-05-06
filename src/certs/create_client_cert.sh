#!/bin/bash
#-------------------------------------------------
#-- Client
#-- Common name is the most important field. It is used as the client name for the mqtt broker
#-------------------------------------------------
username="${1}"

EASYRSA_REQ_CN="${username}" ./easyrsa --batch gen-req "${username}" nopass
./easyrsa sign-req client "${username}"