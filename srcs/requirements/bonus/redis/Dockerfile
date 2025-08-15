FROM debian:bullseye

RUN apt update && apt install -y \
    redis-server php-redis vim && \
    apt clean &&\
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's:bind 127.0.0.1:# bind 127.0.0.1:g' /etc/redis/redis.conf && \
    sed -i 's:# maxmemory <bytes>:maxmemory 15mb:g' /etc/redis/redis.conf && \
    sed -i 's:# maxmemory-policy noeviction:maxmemory-policy allkeys-lru:g' /etc/redis/redis.conf

CMD [ "redis-server", "/etc/redis/redis.conf", "--protected-mode", "no" ]