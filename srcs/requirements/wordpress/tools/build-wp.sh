#/bin/bash

wp core download
wp core config --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD