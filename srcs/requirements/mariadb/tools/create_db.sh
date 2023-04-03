#!/bin/sh

if [ ! -f /var/lib/mysql/installed ]; then
    mariadb-install-db
    touch /var/lib/mysql/installed
    mariadbd & sleep 1
    echo "creating database and user"
    mariadb -e "USE mysql;"
    mariadb -e "DELETE FROM mysql.user WHERE User='';"
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE ${MYSQL_DB};"
    mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'%';"
    mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    pkill mariadbd
    sleep 1
else
    echo "mariadb already installed and set up"
fi

exec $@