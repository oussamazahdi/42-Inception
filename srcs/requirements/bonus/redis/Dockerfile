FROM debian:bullseye

RUN apt update && apt install -y \
    redis-server php-redis vim && \
    apt clean &&\
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's/bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis/redis.conf && \
    sed -i 's/# maxmemory <bytes>/maxmemory 15mb/g' /etc/redis/redis.conf && \
    sed -i 's/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g' /etc/redis/redis.conf && \
    sed -i 's/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g' /etc/redis/redis.conf && \
    sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
    # echo "protected-mode no" >> /etc/redis.conf

ENTRYPOINT ["redis-server"]
