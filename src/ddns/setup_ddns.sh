#!/bin/bash

# Dinamic DNS
(crontab -l 2>/dev/null; echo "4,9,14,19,24,29,34,39,44,49,54,59 * * * * sleep 35 ; wget --no-check-certificate -O - https://freedns.afraid.org/dynamic/update.php?aFROdDhSeU5oUWF3VHBsxptoYkdBYnY6MjAwOTE5OTU= >> /tmp/freedns_brunomld_chickenkiller_com.log 2>&1 &") | crontab -
