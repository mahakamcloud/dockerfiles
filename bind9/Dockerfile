FROM alpine:latest

RUN apk --update add bind

EXPOSE 53

RUN mkdir /var/cache/bind/ && chown named:named /var/cache/bind && \
    mkdir -p /var/lib/bind/zones && chown named:named /var/lib/bind/zones

COPY --chown=named:named ./conf/named.conf.local /etc/bind/named.conf.local
COPY --chown=named:named ./conf/named.conf.options /etc/bind/named.conf.options
COPY --chown=named:named ./conf/named.conf /etc/bind/named.conf
COPY --chown=named:named ./conf/db.mahakam.vpc /var/lib/bind/zones/db.mahakam.vpc
# change CIDR in below file name
COPY --chown=named:named ./conf/db.10.32 /var/lib/bind/zones/db.10.32


CMD ["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]
