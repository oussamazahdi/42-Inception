#!/bin/bash



#we should to add vars to secrets and .env file


# Start MySQL server
mysqld_safe --skip-networking &

# Configure MySQL
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

# Stop MySQL server
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MySQL server in safe mode
exec mysqld_safe