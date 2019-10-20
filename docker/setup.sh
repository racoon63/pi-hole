#!/bin/bash

set -e

read -s -p "Please enter your webpassword [supersecret123]: " PW
echo
read -p "Please enter the IP address of your pihole: " HOSTIP

while [[ ! ${HOSTIP} ]]
do
  read -p "Please enter the IP address of your pihole: " HOSTIP
done

read -p "On which port should the pi-hole web interface run? [8000]: " WEBPORT

if [[ $PW -eq "" ]]
then
  PW="supersecret123"
fi

if [[ $WEBPORT -eq "" ]]
then
  WEBPORT=8000
fi

docker volume create pihole

docker run --detach \
           --name pihole \
           --volume pihole:/etc/pi-hole \
           --volume pihole:/etc/dnsmasq \
           --env TZ="Europe/Berlin" \
           --env WEBPASSWORD=$PW \
           --env ServerIP=$HOSTIP \
           --restart=unless-stopped \
           --publish $WEBPORT:80 \
           --publish 8001:443 \
           --publish 53:53 \
           --publish 67:67 \
           pihole/pihole

echo "FINISHED"