#!/bin/bash

set -ex

read -s -p "Please enter your webpassword [supersecret123]: " PW
read -p "Please enter the IP address of your pihole: " HOSTIP
read -p "On which port should the pi-hole web interface run? [8000]: " WEBPORT

docker volume create pihole

mkdir -p /var/run/docker/volumes/pihole/pihole
mkdir -p /var/run/docker/volumes/pihole/dnsmasq

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