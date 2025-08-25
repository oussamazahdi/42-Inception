all: up

up:
	@mkdir -p /home/ozahdi/data/wordpress
	@mkdir -p /home/ozahdi/data/mariadb
	@mkdir -p /home/ozahdi/data/portainer
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up  --build -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@docker system prune -af
	@docker volume prune -f
	@sudo rm -rf /home/ozahdi/data

re: clean all
