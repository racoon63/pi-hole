#!/bin/bash

set -e

read -s -p "Please enter your webpassword [supersecret123]: \n" PW

read -p "Please enter the IP address of your pihole: \n" HOSTIP

read -p "On which port should the pi-hole web interface run? [8000]: " WEBPORT

docker volume create pihole

sudo mkdir -p /var/run/docker/volumes/pihole/pihole
sudo mkdir -p /var/run/docker/volumes/pihole/dnsmasq

docker run -d \
           --name pihole \
           --volume pihole/pihole:/etc/pi-hole \
           --volume pihole/dnsmasq:/etc/dnsmasq \
           --env TZ="Europe/Berlin" \
           --env WEBPASSWORD=$PW \
           --env ServerIP=$HOSTIP \
           --restart=unless-stopped \
           --publish $WEBPORT:80 \
           --publish 8001:443 \
           --publish 53:53 \
           --publish 67:67
           pihole/pihole

echo "FINISHED"