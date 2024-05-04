#!/bin/bash
#-------------------------------------------------
#-- Certificate Authority
#-------------------------------------------------

mkdir -p ./certs

#-- create key
openssl genrsa -des3 -out ca.key 2048
#(password= wek...)

#-- create cert
openssl req -x509 -newkey rsa:4096 -keyout ca.key -sha256 -days 3650 -nodes -out ca.crt -subj '/C=PT/ST=Lx/L=Mafra/O=${1}/OU=CA-department/CN=${1}/' -addext 'subjectAltName=DNS:${1}'
