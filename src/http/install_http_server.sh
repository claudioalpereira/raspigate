#!/bin/bash

# Taken from: https://ohdoylerules.com/snippets/raspberry-pi-php-and-lighttpd/

# Update the local packages already installed:
sudo apt-get update

# Install the dependencies needed to add the additional services:
sudo apt-get install -y lsb-release apt-transport-https ca-certificates

# Add the repository for installing the latest version of PHP:
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://origin.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

# Now we can install all the PHP packages we will need for basic PHP applications:
# If you need additional PHP extensions then this command is where you would add those in.
sudo apt-get update
sudo apt-get install -y php8.1 php8.1-cli php8.1-cgi php8.1-intl php8.1-zip

# install composer, the package manager for PHP (taken from https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT

# We can remove apache2, given we are not going to use it:
sudo systemctl stop apache2.service
sudo apt remove apache2

# The last thing to install will be lighttpd:
sudo apt-get install -y lighttpd lighttpd-doc

# We also want to enable the PHP modules inside lighttpd so that we can process .php files:
sudo lighttpd-enable-mod fastcgi fastcgi-php

# In order for the web server to properly run, serve our files, and store logs and caches, 
# we need to make sure the folders have the right ownership rules:
sudo chown -R www-data:www-data /var/log/lighttpd
sudo chown -R www-data:www-data /var/cache/lighttpd
sudo chown -R www-data:www-data /var/www/html

# To test out the server once we are finished, we can setup this simple project that emulates the apache directory listing module.
# This will just list everything in our /var/www/html folder in a nice display:
sudo apt-get install -y git
sudo git clone https://github.com/halgatewood/file-directory-list /var/www/html/listing

# We can now make sure the lighttpd service is running so it will always start when we restart our pi:
sudo systemctl start lighttpd.service

# enable CGI
sudo lighty-enable-mod cgi

sudo service lighttpd force-reload
