#------Colors--------
EOC		=	"\033[0;0m"
RED		=	"\033[1;31m"
YELLOW	=	"\033[1;33m"
GREEN	=	"\033[1;32m"
#====================
ifeq ($(shell uname), Linux)
	DIR:=/home/dfranke/data/
endif

ifeq ($(shell uname), Darwin)
	DIR:=/Users/dfranke/data/
endif

all: up

up:	add_host add_volumes
	@if [ ! -f ./srcs/.env ]; then \
		echo $(RED) "\".env\" file is not existing, please edit \"./srcs/env_to_edit\" with desired credentials and rename it to \".env\"" $(EOC); \
	else \
		docker-compose -f ./srcs/docker-compose.yml up -d --build; \
	fi

down:
	@docker compose -f ./srcs/docker-compose.yml down

add_host:
	@if ! grep -q "dfranke.42.fr" /etc/hosts; then \
        sudo sh -c 'echo "127.0.0.1 dfranke.42.fr" >> /etc/hosts'; \
		echo $(YELLOW) "Added \"dfranke.42.fr\" to \"/etc/hosts\" file" $(EOC); \
	else \
	     echo $(GREEN) "\"/etc/hosts\" OK" $(EOC); \
    fi

add_volumes:
	@sudo mkdir -p $(DIR)mariadb
	@sudo chown -R $(shell whoami) $(DIR)mariadb/
	@sudo mkdir -p $(DIR)wordpress
	@sudo chown -R $(shell whoami) $(DIR)wordpress/
	@sudo touch $(DIR)initialized

clean_volumes:

	@if [ -f $(DIR)initialized ]; then \
		docker volume rm mdb_volume wp_volume > /dev/null; \
		sudo rm -rf $(DIR)mariadb; \
		sudo rm -rf $(DIR)wordpress; \
		sudo rm -rf $(DIR)initialized; \
		echo $(RED) "Volumes removed from Docker & \"/Users/dfranke/data/*\"" $(EOC); \
	fi

clean_host:
	@if grep -q "dfranke.42.fr" /etc/hosts; then \
		sudo sed -i -e '/127.0.0.1 dfranke.42.fr/d' /etc/hosts; \
		echo $(RED) "\"dfranke.42.fr\" was deleted from \"/etc/hosts\" file" $(EOC); \
	fi

clean:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all
	@echo $(RED) "All affiliated images deleted" $(EOC);
	
	@make -s clean_volumes
	@make -s clean_host

re: clean all


