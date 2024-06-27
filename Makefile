# Définir la variable USER
USER := $(shell whoami)
HOME_DIR := /home/$(USER)

# Start docker
all: create_data_mariadb create_data_wordpress
	docker compose -f srcs/docker-compose.yml up

# Create local volume
create_data_wordpress:
	@if [ ! -d "$(HOME_DIR)/data/wordpress" ]; then \
		echo "Creating $(HOME_DIR)/data/wordpress directory..."; \
		mkdir -p $(HOME_DIR)/data/wordpress; \
	else \
		echo "$(HOME_DIR)/data/wordpress already exists."; \
	fi

create_data_mariadb:
	@if [ ! -d "$(HOME_DIR)/data/mariadb" ]; then \
		echo "Creating $(HOME_DIR)/data/mariadb directory..."; \
		mkdir -p $(HOME_DIR)/data/mariadb; \
	else \
		echo "$(HOME_DIR)/data/mariadb already exists."; \
	fi

clean:
	docker stop $(docker ps -qa); \
	docker rm $(docker ps -qa); \
	docker rmi -f $(docker images -qa); \
	docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q) 2>/dev/null

clean_local : clean
	rm -rf $(HOME_DIR)/data/mariadb/*
	rm -rf $(HOME_DIR)/data/wordpress/*

fclean:
	docker system prune --volumes