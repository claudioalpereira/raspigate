#!/bin/bash

# Dinamic DNS
(crontab -l 2>/dev/null; echo "$1") | crontab -
