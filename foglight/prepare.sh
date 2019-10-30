#!/bin/sh

# create user foglight:foglight
addgroup --gid 9999 foglight
adduser --uid 9999 --gid 9999 --disabled-password --gecos "foglight" foglight
usermod -L foglight

# mkdir fms 
mkdir -p /home/foglight/fms
chmod 700 /home/foglight/fms
chown foglight:foglight /home/foglight/fms
chmod +rw /home/foglight/fms

# mkdir /var/log/foglight
mkdir -p /var/log/foglight
chmod 700 /var/log/foglight
chown foglight:foglight /var/log/foglight

