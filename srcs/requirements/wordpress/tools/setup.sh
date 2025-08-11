#!/bin/bash

set -e

echo "Waiting for MariaDB..."
	while ! nc -z mariadb 3306; do
	  sleep 1
	done
echo "MariaDB is ready!"

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Setting up WordPress..."

	wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
	tar -xzf /tmp/wordpress.tar.gz -C /tmp
	cp -R /tmp/wordpress/* /var/www/html/
	rm -rf /tmp/wordpress*

	wget https://raw.githubusercontent.com/wp-cli/wp-cli/main/phar/wp-cli.phar -O /usr/local/bin/wp
	chmod +x /usr/local/bin/wp

	cd /var/www/html
	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--allow-root

	wp core install \
		--url=$DOMAIN_NAME \
		--title="$WP_TITLE" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root

	wp user create $WP_USER $WP_USER_EMAIL \
		--role=editor \
		--user_pass=$WP_USER_PASSWORD \
		--allow-root

	chown -R wordpress:wordpress /var/www/html
	find /var/www/html -type d -exec chmod 755 {} \;
	find /var/www/html -type f -exec chmod 644 {} \;
fi

exec php-fpm7.4 -F
