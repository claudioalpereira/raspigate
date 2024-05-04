#!/bin/bash
#-------------------------------------------------
#-- Client
#-- Common name is the most important field. It is used as the client name for the mqtt broker
#-------------------------------------------------

# TODO: validate arg.
# Validation if there'a already a mqtt user with this name should be done in the calling code, not here

mkdir -p ./certs

#-- Generate a client key.
openssl genrsa -passout pass: -out "${1}.key" 2048
#when requested for a passphrase, do not define any (press enter)

#-- Generate a certificate signing request to send to the CA.
openssl req -out "${1}.csr" -key "${1}.key" -new \
    -subj '/C=PT/ST=Mafra/L=Montemuro/O=${1}/OU=${1}/CN=${1}/'

#-- Send the CSR to the CA, or sign it with your CA key:
openssl x509 -req -in "${1}.csr" -CA ca.crt -CAkey ca.key -CAcreateserial -out "${1}.crt" -days 3650

#-- converter os ficheiros .cert e .key no formato pkcs12
openssl pkcs12 -export -in "${1}.crt" -inkey "${1}.key" -name "${1}'s certificate/key" -out "${1}.p12" -passout pass:
