FROM ubuntu:bionic as builder

ARG KEA_DHCP_VERSION=1.5.0
WORKDIR /opt

RUN apt-get update && apt-get install -y \
        automake \
        build-essential \
        ccache \
        docbook-xsl \
        doxygen \
        elinks \
        libboost-dev \
        libboost-system-dev \
        liblog4cplus-dev \
        libpq-dev \
        libssl-dev \
        libtool \
        pkg-config \
        postgresql-server-dev-all \
        python3 \
        wget \
        xsltproc

ENV PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
ENV CC="ccache gcc" CXX="ccache g++"
ENV PATH $PATH:/usr/lib64/ccache

RUN wget https://ftp.isc.org/isc/kea/1.5.0/kea-1.5.0.tar.gz -O - | tar -xz && \
    cd kea-1.5.0 && ./configure \
    --enable-shell \
    --with-openssl \
    --with-log4cplus=/usr/include/log4cplus \
    --enable-logger-checks \
    --enable-install-configurations \
    --with-pgsql \
    --enable-generate-docs && \
    make && \
    make install

FROM ubuntu:bionic as kea-dhcp
RUN apt-get update && apt-get install -y \
    inotify-tools \
    libboost-dev \
    libboost-system-dev \
    libpq-dev \
    liblog4cplus-dev \
    supervisor && \
    mkdir -p /usr/local/var/run/kea && \
    mkdir -p /usr/local/var/kea/ && \
    mkdir -p /var/log/supervisor
COPY --from=builder /usr/local/include/kea/ /usr/local/include/kea/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/sbin/kea* /usr/local/sbin/
COPY --from=builder /usr/local/etc/kea/ /usr/local/etc/kea/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /usr/local/share/kea/ /usr/local/share/kea/
COPY --from=builder /usr/local/share/doc/kea/ /usr/local/share/doc/kea/
COPY ./watch_dhcp_conf.sh /watch_dhcp_conf.sh
ENV LD_LIBRARY_PATH=/usr/local/lib

COPY ./conf/supervisor/kea-dhcp.conf /etc/supervisor/conf.d/
CMD ["/usr/bin/supervisord"]

# check DHCP bind ip

FROM postgres:11.2-alpine as kea-dhcp-postgres
COPY --from=builder /usr/local/share/kea/scripts/pgsql/dhcpdb_create.pgsql /docker-entrypoint-initdb.d/dhcpdb_create.sql

