FROM debian:bookworm

RUN apt update && apt install -y curl adminer \
    php8.2-fpm  php8.2-mysql  php8.2-cli
RUN cp /usr/share/adminer/adminer.php /var/www/html/index.php
RUN chown www-data:www-data /var/www/html && chmod 755 /var/www/html
RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 5000|g" /etc/php/8.2/fpm/pool.d/www.conf

CMD ["php-fpm8.2", "--nodaemonize"]
