#!/bin/bash

sleep 10

print_green() {
    echo -e "\033[31m$1\033[0m"
}


FILENAME="wp-config.php"
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
	echo "/run/php was create"
else
	echo "/run/php exist"
fi

print_green "4 Set site"
wp core install --allow-root --title="Le bokit du soir" \
	--path='var/www/wordpress' \
	--admin_user=scely \
	--admin_password=cely \
	--skip-email \

print_green "5 Set user"
# Just for testing - to be removed in production
wp user create --allow-root stayssy judor stayssy@domain.com --role="author" \
	--path='var/www/wordpress' \
	--user_pass="123456789" \
	--first_name="stayssy" \
	--last_name="judor"


print_green 5
exit 0
php-fpm7.4 -F