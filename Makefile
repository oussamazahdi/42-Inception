all: up

up:
	@mkdir -p /goinfre/ozahdi/data/wordpress
	@mkdir -p /goinfre/ozahdi/data/mariadb
	@mkdir -p /goinfre/ozahdi/data/portainer
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up  --build -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@docker system prune -af
	@docker volume prune -f
	@rm -rf /goinfre/ozahdi/data

re: clean all
