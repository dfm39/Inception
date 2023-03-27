SHELL=/bin/bash

#------Colors--------
RED	=	"\033[1;31"
EOC	=	"\033[0;0m"
#====================

all: up

up: 
	@ if [ ! -f ./srcs/.env ]; then \
		echo -e "'.env' file is not existing, please edit ./srcs/env_to_edit with desired credentials and rename it to .env"; \
	else \
		docker-compose -f ./srcs/docker-compose.yml up -d --build; \
	fi

down: 
	@ docker compose -f ./srcs/docker-compose.yml down

clean:	down
	@ sudo rm -rf ~/data/wordpress
	@ sudo rm -rf ~/data/mariadb