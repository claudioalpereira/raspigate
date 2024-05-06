#!/bin/bash
#-------------------------------------------------
#-- Certificate Authority
#-------------------------------------------------

# TODO: Implement 3 options
#   1- CA with no password (this option)
#   2- Accept the CA pass from the user (more secure, but cannot be completely unattended and the user MUST remember the pass)
#   3- Store the CA on a pendrive. keep the pen removed from the raspberry and attach it only when the user need to create new certs

sudo apt-get install -y easy-rsa
make-cadir certs
cd certs
./easyrsa init-pki
./easyrsa build-ca nopass
cd ..
