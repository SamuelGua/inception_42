#!/bin/bash

sleep 20

print_green() {
    echo -e "\033[32m$1\033[0m"
}

print_red() {
    echo -e "\033[1;31mError: $1\033[0m"
}

while ! mysqladmin ping -h mariadb --silent; do
    print_green "Waiting for MariaDB to be ready..."
    sleep 2
done

# Chemin du modèle de configuration de WP-CLI
FILENAME="/var/www/wordpress/wp-config.php"
print_green "1. Vérification de la configuration WordPress..."
if [ ! -f "$FILENAME" ]; then
    echo "$FILENAME n'existe pas"
    wp-cli.phar config create --allow-root \
        --path='/var/www/wordpress' \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306"
    if [ $? -ne 0 ]; then
        print_red "Erreur lors de la création de wp-config.php"
        exit 1
    fi

    print_green "1.1 Configuration du site WordPress..."
    wp-cli.phar core install --allow-root \
        --path='/var/www/wordpress' \
        --url='scely.42.fr' \
        --title="$SITE_TITLE" \
        --admin_user="$USER_1_NAME" \
        --admin_password="$USER_1_PASSWORD" \
        --admin_email="$USER_1_EMAIL" \
        --skip-email
    if [ $? -ne 0 ]; then
        print_red "Erreur lors de l'installation de WordPress"
        exit 1
    fi

    print_green "1.2 Création de l'utilisateur WordPress..."
    wp-cli.phar user create "$WP_USER" "$WP_EMAIL" \
        --allow-root \
        --path='/var/www/wordpress' \
        --first_name="$WP_FIRST_NAME" \
        --last_name="$WP_LAST_NAME" \
        --user_pass="$WP_PASSWORD" \
        --role="$WP_ROLE"
    if [ $? -ne 0 ]; then
        print_red "Erreur lors de la création de l'utilisateur WordPress"
        exit 1
    fi
else
    echo "$FILENAME existe déjà"
fi

print_green "Vérification du répertoire run/php"
if [ ! -d "/run/php" ]; then
    mkdir "/run/php"
else
    echo "/run/php existe déjà"
fi

print_green "Its ok"

php-fpm7.4 -F