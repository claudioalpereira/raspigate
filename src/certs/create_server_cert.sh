#!/bin/bash
#-------------------------------------------------
#-- Generate server cert to use with mosquitto
#-------------------------------------------------

mkdir -p ./certs

#-- create server key
openssl genrsa -out server.key 2048

#-- create request for CA emitir um cert
openssl req -new -key server.key -out server.csr -config server_cert_config.cnf 

#-- emitir o cert com CA
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -extensions req_ext -extfile server_cert_config.cnf

