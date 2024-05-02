#!/bin/bash
#-------------------------------------------------
#-- Client (replace claudio-iphone by the name of the client)
#-- Common name is the most important field. It is used as the client name for the mqtt broker
#-------------------------------------------------

mkdir -p ./certs

#-- Generate a client key.
openssl genrsa -out claudio-iphone.key 2048
#when requested for a passphrase, do not define any (press enter)

#-- Generate a certificate signing request to send to the CA.
openssl req -out claudio-iphone.csr -key claudio-iphone.key -new \
    -subj '/C=PT/ST=Mafra/L=Montemuro/O=claudio-iphone/OU=claudio-iphone/CN=claudio-iphone/'

#-- Send the CSR to the CA, or sign it with your CA key:
openssl x509 -req -in claudio-iphone.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out claudio-iphone.crt -days 3650

#-- converter os ficheiros .cert e .key no formato pkcs12
openssl pkcs12 -export -in claudio-iphone.crt -inkey claudio-iphone.key -name "claudio-iphone's certificate/key" -out claudio-iphone.p12
