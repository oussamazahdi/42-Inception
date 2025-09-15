FROM debian:oldstable

RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysql wget php-redis redis-server

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT [ "setup.sh" ]