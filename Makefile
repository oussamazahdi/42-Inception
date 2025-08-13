NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env

# Colors
GREEN = \033[0;32m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m

.PHONY: all build up down clean fclean re logs status

all: build up

build:
	@echo "$(BLUE)Building Docker images...$(NC)"
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) build

up:
	@echo "$(GREEN)Starting services...$(NC)"
	@docker-compose -p "" -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d

down:
	@echo "$(RED)Stopping services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down

clean: down
	@echo "$(RED)Cleaning up containers and networks...$(NC)"
	@docker system prune -f

fclean: down
	@echo "$(RED)Full cleanup - removing everything...$(NC)"
	@docker system prune -af
	@docker volume prune -f
	@sudo rm -rf /home/$(USER)/data

re: fclean all

logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

status:
	@echo "$(BLUE)Docker containers status:$(NC)"
	@docker ps -a
	@echo "$(BLUE)Docker volumes:$(NC)"
	@docker volume ls
	@echo "$(BLUE)Docker networks:$(NC)"
	@docker network ls

# Individual service controls
mariadb:
	@docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d mariadb

wordpress:
	@docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d wordpress

nginx:
	@docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d nginx

# Debugging commands
shell-nginx:
	@docker exec -it nginx bash

shell-wordpress:
	@docker exec -it wordpress bash

shell-mariadb:
	@docker exec -it mariadb bash

# Logs for individual services
logs-nginx:
	@docker logs nginx -f

logs-wordpress:
	@docker logs wordpress -f

logs-mariadb:
	@docker logs mariadb -f