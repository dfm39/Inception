FROM alpine:latest


RUN		apk update && apk add --no-cache \
		bash \
		curl \
		php81 \
		php81-fpm \
		php81-cli \
		php81-cgi \
		php81-mysqli \
		php81-pdo \
		php81-gd \
		php81-mbstring
		
RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000
	
CMD [ "php-fpm81", "-F" ,"-R" ]
