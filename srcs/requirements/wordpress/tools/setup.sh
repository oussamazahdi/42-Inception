#!/bin/bash

set -e

if [ ! -f /var/www/html/wp-config.php ]; then

	wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
	tar -xf /tmp/wordpress.tar.gz -C /tmp
	cp -R /tmp/wordpress/* /var/www/html/
	rm -rf /tmp/wordpress*

	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
	chmod +x /usr/local/bin/wp

	cd /var/www/html
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 --allow-root --path=/var/www/html

	wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root \
		--path=/var/www/html

	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD \
		--allow-root --path=/var/www/html

	wp theme install twentytwentyfour --allow-root
	wp theme activate twentytwentyfour --allow-root


	wp plugin install redis-cache --activate --allow-root
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --raw --allow-root
	wp redis enable --allow-root

fi

exec php-fpm8.2 -F
