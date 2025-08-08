# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

# Install MariaDB server and client
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /usr/local/bin/setup.sh

# Copy setup script
RUN chmod +x /usr/local/bin/setup.sh

# Create directory for MariaDB runtime files
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

# Create directory for MariaDB data
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql

# Set working directory
WORKDIR /var/lib/mysql

# Run setup script
ENTRYPOINT ["/usr/local/bin/setup.sh"]
