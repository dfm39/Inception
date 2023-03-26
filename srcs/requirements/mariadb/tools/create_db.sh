#!/bin/bash

mariadb-install-db
mariadbd & sleep 3
echo "CREATE DATABASE"
mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"
mariadb -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -e "CREATE DATABASE wordpress;"
mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
echo "DONE CREATING DATABASE"
# pkill mariadbd

exec $@