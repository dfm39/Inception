#------Colors--------
EOC		=	"\033[0;0m"
RED		=	"\033[1;31m"
YELLOW	=	"\033[1;33m"
GREEN	=	"\033[1;32m"
#====================

all: up

up:	add_host add_vol_folder
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

add_vol_folder:
	@if [ -d /Users ]; then \
		sudo mdkir -p /Users/dfranke/data/mariadb; \
		sudo mdkir -p /Users/dfranke/data/wordpress; \
		sudo touch /Users/dfranke/data/initialized; \
	else \
		sudo mkdir -p /home/dfranke/data/mariadb; \
		sudo mkdir -p /home/dfranke/data/wordpress; \
		sudo touch /home/dfranke/data/initialized; \
	fi

clean_volumes:

	@if [ -f /Users/dfranke/data/initialized ]; then \
		sudo rm -rf /Users/dfranke/data/mariadb; \
		sudo rm -rf /Users/dfranke/data/wordpress; \
		sudo rm -rf /Users/dfranke/data/initialized; \
		docker volume rm mdb_volume wp_volume > /dev/null; \
		echo $(RED) "Volumes removed from Docker & \"/Users/dfranke/data/*\"" $(EOC); \
	fi

	@if [ -f /home/dfranke/data/initialized ]; then \
		sudo rm -rf /home/dfranke/data/mariadb; \
		sudo rm -rf /home/dfranke/data/wordpress; \
		sudo rm -rf /home/dfranke/data/initialized; \
		docker volume rm mdb_volume wp_volume > /dev/null; \
		echo $(RED) "Volumes removed from Docker & \"/home/dfranke/data/*\"" $(EOC); \
	fi

clean_host:
	@if grep -q "dfranke.42.fr" /etc/hosts; then \
		sudo sed -i -e '/127.0.0.1 dfranke.42.fr/d' /etc/hosts; \
		echo $(RED) "\"dfranke.42.fr\" was deleted from \"/etc/hosts\" file" $(EOC); \
	fi

clean:
	@docker compose -f ./srcs/docker-compose.yaml down --rmi all
	@echo $(RED) "All affiliated images deleted" $(EOC);
	
	@make -s clean_volumes
	@make -s clean_host

re: clean all


