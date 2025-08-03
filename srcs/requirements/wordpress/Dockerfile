FROM debian:bullseye

RUN apt-get update  && apt-get install -y \
    wget \
    php7.3 \
    php-fpm \
    php-mysql \
    mariadb-client \
    && wget https://www.wordpress.org/wordpress-6.8.2.tar.gz -P /var/www \
    && cd /var/www && tar -xzf wordpress-6.8.2.tar.gz && rm wordpress-6.8.2.tar.gz \
    && chown -R root:root /var/www/wordpress