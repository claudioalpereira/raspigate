# raspigate

## Installation
``` bash
sudo curl -L https://raw.githubusercontent.com/claudioalpereira/raspigate/main/src/raspigate | bash
```

## TEST: connect to VPN

As part of the installation, a test client is created and a qr code is generated.
install the wireguard app (android/iphone) and scan the qr code
This should be enought.

## TEST: mqtt

A test mqtt client is also created. send the 3 files to any client and test mqttt with the client cert.

scp pi@10.10.10.101:~/certs/pki/issued/test-client.crt ./
scp pi@10.10.10.101:~/certs/pki/private/test-client.key ./
scp pi@10.10.10.101:~/certs/pki/ca.crt ./

mosquitto_pub --ca-path ./ca.crt --cert test-client.crt --key ./test-client.key -h brunomld.chickenkiller.com -t test -m olá

