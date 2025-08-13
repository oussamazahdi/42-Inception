COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env


all: up

up:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d --build

down:
	@docker-compose -f $(COMPOSE_FILE) down

clean: down
	@docker system prune -af
	@docker volume prune -f
	@sudo rm -rf /home/$(USER)/data

re: fclean all
