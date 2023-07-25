FROM ghcr.io/andronics/base:main

LABEL org.opencontainers.image.source="https://github.com/andronics/docker-proxy.git" \
    org.opencontainers.image.url="https://github.com/andronics/docker-proxy"

COPY ./services.d /etc/services.d

RUN \
    echo "# Installing Packages #" && \
        apk --no-cache --update add \
            bind-tools=9.18.16-r0 \
            dante-server=1.4.3-r3 \
            tinyproxy=1.11.1-r3 \
            unbound=1.17.1-r1 && \
    echo "# Removing Cache #" && \
        rm -rf /var/cache/apk/* && \
    echo "# Chaning Permissions #" && \
        find /etc/services.d -type f -exec chmod u+x {} \; && \
    echo "# Updating Unbound Internic Root Hints" && \
        curl -s https://www.internic.net/domain/named.cache -o /etc/unbound/root.hints 

