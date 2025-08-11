# Variables
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data

# Default target
all: build

# Create data directories
setup:
	@echo "Creating data directories..."
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)

# Build and start services
build: setup
	@echo "Building and starting services..."
	@docker-compose -f $(COMPOSE_FILE) up --build -d

# Start services
up:
	@docker-compose -f $(COMPOSE_FILE) up -d

# Stop services
down:
	@docker-compose -f $(COMPOSE_FILE) down

# Clean everything
clean: down
	@echo "Cleaning containers, images, and volumes..."
	@docker system prune -af
	@docker volume prune -f

# Full cleanup including data
fclean: clean
	@echo "Removing data directories..."
	@sudo rm -rf $(DATA_PATH)

# Rebuild everything
re: fclean all

# Show logs
logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

# Show status
status:
	@docker-compose -f $(COMPOSE_FILE) ps

.PHONY: all build up down clean fclean re logs status setup
