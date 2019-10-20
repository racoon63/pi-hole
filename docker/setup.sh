#!/bin/bash

set -e

IP=$(hostname -I | awk '{ print $1 }')

read -s -p "Please enter your webpassword [supersecret123]: " PW

if [[ ! ${PW} ]]
then
  PW="supersecret123"
fi

echo
read -p "Please enter the IP address of your pihole [$IP]: " HOSTIP

if [[ ! ${HOSTIP} ]]
then
  HOSTIP=$IP
fi

read -p "On which port should the pi-hole web interface run? [8080]: " WEBPORT

if [[ ! ${WEBPORT} ]]
then
  WEBPORT=8080
fi

docker volume create pihole

docker run --detach \
           --name pihole \
           --volume pihole:/etc/pi-hole \
           --volume pihole:/etc/dnsmasq \
           -e TZ="Europe/Berlin" \
           -e WEBPASSWORD=$PW \
           -e ServerIP=$HOSTIP \
           -e DNS1=127.0.0.1 \
           -e DNS2=1.1.1.1 \
           --restart=unless-stopped \
           --publish $WEBPORT:80 \
           --publish 8001:443 \
           --publish 53:53 \
           --publish 67:67 \
           --cap-add NET_ADMIN \
           pihole/pihole

echo "FINISHED"