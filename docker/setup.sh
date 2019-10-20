#!/bin/bash

set -e

IP=$(hostname -I | awk '{ print $1 }')

read -s -p "Please enter your webpassword [supersecret123]: " PW
echo
read -p "Please enter the IP address of your pihole [$IP]: " HOSTIP

while [[ ! ${HOSTIP} ]]
do
  read -p "Please enter the IP address of your pihole: " HOSTIP
done

read -p "On which port should the pi-hole web interface run? [8000]: " WEBPORT

if [[ ! ${PW} ]]
then
  PW="supersecret123"
fi

if [[ ! ${WEBPORT} ]]
then
  WEBPORT=8000
fi

docker volume create pihole

docker run --detach \
           --name pihole \
           --volume pihole:/etc/pi-hole \
           --volume pihole:/etc/dnsmasq \
           -e TZ="Europe/Berlin" \
           -e WEBPASSWORD=$PW \
           -e ServerIP=$HOSTIP \
           --restart=unless-stopped \
           --publish $WEBPORT:80 \
           --publish 8001:443 \
           --publish 53:53 \
           --publish 67:67 \
           --cap-add NET_ADMIN \
           -e dns=127.0.0.1 \
           -e dns=1.1.1.1 \
           pihole/pihole

echo "FINISHED"