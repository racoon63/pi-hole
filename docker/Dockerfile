FROM pihole/pihole

ENV TZ='Europe/Berlin'
ENV WEBPASSWORD='supersecret1234'

COPY *.list /pihole

EXPOSE 53:53/tcp
EXPOSE 53:53/udp
EXPOSE 67:67/udp
EXPOSE 80:80/tcp
EXPOSE 443:443/tcp

WORKDIR /

ENTRYPOINT ["/s6-init"]