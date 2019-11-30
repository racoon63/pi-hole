#!/bin/bash

TIMESTAMP=$(date +%Y%m%d%H%M%S)

tar -czvf $TIMESTAMP-pihole-conf-backup.tar.gz \
    -C /etc/pihole
    adlists.list \
    dns-servers.conf \
    local.list \
    regex.list \
    setupVars.conf

tar -czvf $TIMESTAMP-pihole-logs-backup.tar.gz 
    -C /var/log/ \
    pihole.log \
    pihole-FTL.log \
    lighttpd/access.log \
    lighttpd/error.log
