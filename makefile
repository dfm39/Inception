#------Colors--------
EOC		=	"\033[0;0m"
RED		=	"\033[1;31m"
YELLOW	=	"\033[1;33m"
GREEN	=	"\033[1;32m"
#====================

all: up

up:	add_host 
	@if [ ! -f ./srcs/.env ]; then \
		echo $(RED) "\".env\" file is not existing, please edit \"./srcs/env_to_edit\" with desired credentials and rename it to \".env\"" $(EOC); \
	else \
		docker-compose -f ./srcs/docker-compose.yaml up -d --build; \
	fi

down:
	@ docker compose -f ./srcs/docker-compose.yaml down

add_host:
	@if ! grep -q "dfranke.42.fr" /etc/hosts; then \
        sudo sh -c 'echo "127.0.0.1 dfranke.42.fr" >> /etc/hosts'; \
		echo $(YELLOW) "Added \"dfranke.42.fr\" to \"/etc/hosts\" file" $(EOC); \
	else \
	     echo $(GREEN) "\"/etc/hosts\" OK" $(EOC); \
    fi

clean_host:
	@if grep -q "dfranke.42.fr" /etc/hosts; then \
		sudo sed -i -e '/127.0.0.1 dfranke.42.fr/d' /etc/hosts; \
		echo $(RED) "\"dfranke.42.fr\" was deleted from \"/etc/hosts\" file" $(EOC); \
	fi

re: clean all

clean:
	@docker compose -f ./srcs/docker-compose.yaml down --rmi all
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mariadb
	@echo $(RED) "Volumes cleaned and all images deleted" $(EOC);
	@make -s clean_host



