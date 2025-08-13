FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm php7.4-mysql php7.4-curl \
    php7.4-gd php7.4-intl php7.4-mbstring \
    php7.4-soap php7.4-xml php7.4-xmlrpc \
    php7.4-zip wget curl netcat \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

RUN useradd -r -s /bin/false inception && \
    mkdir -p /var/www/html && \
    chown -R inception:inception /var/www/html

WORKDIR /var/www/html

# EXPOSE 9000

CMD [ "setup.sh" ]