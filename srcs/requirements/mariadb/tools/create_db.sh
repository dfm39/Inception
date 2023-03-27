#!/bin/bash

if [ ! -f /var/lib/mysql/installed ]; then
    mariadb-install-db
    touch /var/lib/mysql/installed
    mariadbd & sleep 3
    echo "creating database and user"
    mariadb -e "set password for 'root'@'localhost' = password('${MYSQL_ROOT_PASSWORD}');"
    mariadb -e "create user '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';"
    mariadb -e "create database ${MYSQL_DB};"
    mariadb -e "grant all privileges on ${MYSQL_DB}.* to '${MYSQL_USER}'@'%';"
    mariadb -e "flush privileges;"
    pkill mariadbd
else
    echo "mariadb already installed and set up"
fi

exec $@