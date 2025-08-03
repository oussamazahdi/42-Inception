FROM debian:bullseye

RUN	apt update -y && apt upgrade -y \
	&& apt install -y \
	mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

WORKDIR /home/

COPY tools/Script.sh /home/

RUN chmod +x /home/Script.sh

CMD [ "Script.sh" ]