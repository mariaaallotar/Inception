VOLUME_DIRECTORY=~/data
COMPOSE_FILE=./srcs/docker-compose.yml

all: wordpress_volume mariadb_volume
	make up

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

down:
	docker compose -f $(COMPOSE_FILE) down

# no need to depend on 'down' when down is the way to remove images anyway
# does work even when the stack is not up
clean: 
	docker compose -f $(COMPOSE_FILE) down --rmi all

fclean: clean
	docker compose -f $(COMPOSE_FILE) down -v
	sudo rm -fr $(VOLUME_DIRECTORY)/wordpress $(VOLUME_DIRECTORY)/mariadb

re: fclean
	make all

wordpress_volume:
	mkdir -m 777 -p $(VOLUME_DIRECTORY)/wordpress

mariadb_volume:
	mkdir -m 777 -p $(VOLUME_DIRECTORY)/mariadb

.PHONY: all up build down clean fclean re wordpress_volume mariadb_volume