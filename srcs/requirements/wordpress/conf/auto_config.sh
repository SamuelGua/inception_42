#!/bin/bash

sleep 10
which php-fpm

FILENAME="wp-config.php"
if [ ! -f "$FILENAME" ]; then
	echo "$FILENAME doesn't exist"
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'
	echo "$FILENAME was created"
else
	echo "$FILENAME exist"
fi

sleep 10

if [ ! -f "/run/php" ]; then
	echo "/run/php doesn't exist"
	mkdir "/run/php"
	echo "/run/php was create"
else
	echo "/run/php exist"
fi

wp core install --allow-root --title="Le bokit du soir" \
	--admin_user=scely \
	--admin_password=cely \
	--skip-email \

# Just for testing - to be removed in production
wp user create --allow-root stayssy judor stayssy@domain.com --role="administrator" \
	--user_pass="123456789" \
	--first_name="stayssy" \
	--last_name="judor"

php-fpm7.4 -F