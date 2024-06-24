#!/bin/bash

#a effacer lors
SQL_DATABASE=samuel
SQL_USER=sam
SQL_ROOT_PASSWORD=123456
SQL_PASSWORD=123456

print_green() {
    echo -e "\033[32m$1\033[0m"
}

print_green "1 : Starting..."

while ! mysqladmin ping --silent; do
    print_green "Waiting for MariaDB..."
    sleep 1
done

print_green "2 : MariaDB setup..."

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

print_green "3 : Initialization script completed."

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

print_green "4 : MariaDB has been stopped."

print_green "everything it's ok or not"
exit 1
exec mysqld_safe --datadir=/var/lib/mysql

