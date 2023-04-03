#/bin/sh

tmp_low=$(echo ${WP_ADMIN} | tr '[:upper:]' '[:lower:]')

if echo $tmp_low | grep -q "admin"; then
    echo "The word admin is not allowed in WP_ADMIN string"
    exit 1
else
    echo "WP_ADMIN string is ok"
fi

cd /var/www/html/

if [ ! -f ./wp-config.php ]; then
    wp core download
    while ! mysqladmin ping -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD --silent; do
    	sleep 1
    done
    wp core config --dbhost=mariadb --dbname=${MYSQL_DB} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD}
    wp core install --url=${DOMAIN} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_MAIL} --skip-email
    wp user create ${WP_USER_NAME} ${WP_USER_MAIL} --user_pass=${WP_USER_PASSWORD}
else
    echo "wordpress is already downloaded & installed"
fi

exec $@