FROM debian:bookworm

RUN apt-get update && apt-get install -y redis-server iproute2

RUN sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0/g" /etc/redis/redis.conf && \
    sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf && \
    sed -i "s/# maxmemory <bytes>/maxmemory 256mb/g" /etc/redis/redis.conf && \
    sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" /etc/redis/redis.conf && \
    sed -i "s/daemonize yes/# daemonize yes/g" /etc/redis/redis.conf


ENTRYPOINT [ "redis-server", "/etc/redis/redis.conf" ]
