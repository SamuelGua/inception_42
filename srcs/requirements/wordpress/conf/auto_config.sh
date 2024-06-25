#!/bin/bash

sleep 10

print_green() {
    echo -e "\033[32m$1\033[0m"
}

FILENAME="var/www/wordpress/wp-config.php"
print_green "1 Init config"
if [ ! -f "$FILENAME" ]; then
	echo "$FILENAME doesn't exist"
	wp config create --allow-root \
		--path='var/www/wordpress' \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306
	echo "$FILENAME was created"
else
	echo "$FILENAME exist"
fi

print_green "2 Check run/php"
if [ ! -f "/run/php" ]; then
	echo "/run/php doesn't exist"
	mkdir "/run/php"
	echo "/run/php was created"
else
	echo "/run/php exist"
fi

print_green "4 Set site"
wp core install --allow-root --title=$SITE_TITLE \
	--path='var/www/wordpress' \
	--admin_user=$USER_1_NAME \
	--admin_password=$USER_1_PASSWORD \
	--skip-email \

print_green "5 Set user"
wp user create --allow-root --role=$WP_ROLE \
	--path='var/www/wordpress' \
	--user_pass=$WP_PASSWORD \
	--first_name=$WP_FIRST_NAME \
	--last_name=$WP_LAST_NAME

php-fpm7.4 -F