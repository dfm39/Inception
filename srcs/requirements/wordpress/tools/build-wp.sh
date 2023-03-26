#/bin/bash

cd /var/www/html/
wp core download
sleep 10;
wp core config --dbhost=mariadb --dbname=wordpress --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD}
chmod 600 wp-config.php
wp core install --url=dfranke.42.fr --title=${WP_TITLE} --admin_name=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_MAIL}
wo core user create ${WP_USER_NAME} ${WP_USER_MAIL} --user_password=${WP_USER_PASSWORD}
exec $@