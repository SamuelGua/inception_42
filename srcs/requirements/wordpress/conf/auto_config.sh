#!/bin/bash

sleep 10

FILENAME="wp-config.php"
if [ ! -F "$FILENAME" ]; then
	echo "$FILENAME doesn't exist"
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'
	echo "$FILENAME was create"
else
	echo "$FILENAME exist"
fi

if [ ! -F "/run/php" ]; then
	echo "/run/php doesn't exist"
	touch "/run/php"
	echo "/run/php was create"
else
	echo "/run/php exist"
fi

wp core install --url=<url>\
	--title=<site-title>\
	--admin_user=<username>\
	--admin_password=<password>
	--admin_email=<email>
	--skip-email

wp user create