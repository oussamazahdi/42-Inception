# Inception

A comprehensive Docker-based infrastructure project that sets up a complete web application stack using containerized services.

## Project Overview

Inception is a system administration and DevOps project that involves creating a multi-container Docker application. The project demonstrates knowledge of containerization, service orchestration, and infrastructure management by setting up a complete web stack from scratch.

## Architecture

The project consists of multiple Docker containers working together:

- **NGINX**: Web server and reverse proxy
- **WordPress**: Content management system
- **MariaDB**: Database management system
- **Additional services**: As per project requirements

All services run in separate containers and communicate through a custom Docker network.

## Requirements

- Docker
- Docker Compose
- Make
- Domain name configured to point to 127.0.0.1 (typically `login.42.fr`)

## Project Structure

```
inception/
├── Makefile
├── docker-compose.yml
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        └── mariadb/
            ├── Dockerfile
            ├── conf/
            └── tools/
```

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd inception
   ```

2. **Configure environment variables**
   ```bash
   cp srcs/.env.example srcs/.env
   # Edit .env file with your configuration
   ```

3. **Add domain to hosts file**
   ```bash
   echo "127.0.0.1    login.42.fr" >> /etc/hosts
   ```

4. **Build and start services**
   ```bash
   make
   ```

## Configuration

### Environment Variables

Create a `.env` file in the `srcs/` directory with the following variables:

```env
# Domain Configuration
DOMAIN_NAME=login.42.fr

# Database Configuration
DB_NAME=wordpress
DB_USER=wpuser
DB_PASSWORD=secure_password
DB_ROOT_PASSWORD=root_password

# WordPress Configuration
WP_TITLE=My WordPress Site
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_USER=user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@example.com
```

### SSL/TLS Configuration

The project uses self-signed SSL certificates for HTTPS:
- Certificates are generated automatically during the build process
- NGINX is configured to serve content over HTTPS only
- HTTP traffic is redirected to HTTPS

## Services

### NGINX
- Acts as a reverse proxy and web server
- Handles SSL/TLS termination
- Serves static content
- Proxies dynamic requests to WordPress

### WordPress
- PHP-FPM based WordPress installation
- Connects to MariaDB database
- Configured with multiple users
- Includes custom themes/plugins if specified

### MariaDB
- MySQL-compatible database server
- Stores WordPress data
- Configured with proper user permissions
- Data persistence through Docker volumes

## Usage

### Starting the Infrastructure
```bash
make up
# or
make all
```

### Stopping the Infrastructure
```bash
make down
```

### Cleaning Up
```bash
make clean      # Stop and remove containers
make fclean     # Clean + remove volumes and images
make re         # Rebuild everything from scratch
```

### Viewing Logs
```bash
make logs
# or for specific service
docker-compose -f srcs/docker-compose.yml logs nginx
```

### Accessing Services
- **Website**: https://login.42.fr
- **WordPress Admin**: https://login.42.fr/wp-admin

## Docker Configuration

### Custom Network
All services communicate through a custom Docker network, ensuring isolation and proper service discovery.

### Volumes
Persistent data storage for:
- WordPress files
- Database data
- SSL certificates

### Health Checks
Each service includes health checks to ensure proper startup order and service availability.

## Security Considerations

- All services run as non-root users where possible
- Sensitive data is stored in environment variables
- SSL/TLS encryption for all web traffic
- Database access restricted to WordPress container
- Regular security updates through base image selection

## Troubleshooting

### Common Issues

1. **Port conflicts**
   ```bash
   # Check if ports 80/443 are in use
   sudo netstat -tlnp | grep :80
   sudo netstat -tlnp | grep :443
   ```

2. **Permission issues**
   ```bash
   # Ensure proper ownership of volumes
   sudo chown -R $USER:$USER srcs/
   ```

3. **DNS resolution**
   ```bash
   # Verify domain points to localhost
   ping login.42.fr
   ```

4. **SSL certificate issues**
   ```bash
   # Regenerate certificates
   make fclean && make
   ```

### Debug Mode
```bash
# Run with verbose output
docker-compose -f srcs/docker-compose.yml up --build
```

## Project Goals

This project demonstrates proficiency in:
- Docker containerization
- Service orchestration with Docker Compose
- Infrastructure as Code principles
- Web server configuration
- Database administration
- SSL/TLS implementation
- System administration best practices

## Bonus Features

If implementing bonus features:
- Redis caching
- FTP server
- Additional services as specified
- Advanced monitoring and logging
- Backup and restore functionality

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [NGINX Configuration Guide](https://nginx.org/en/docs/)
- [WordPress Configuration](https://wordpress.org/support/article/editing-wp-config-php/)
- [MariaDB Documentation](https://mariadb.org/documentation/)

## Author

[Oussama Zahdi] - [@oussamazahdi]

## License

This project is part of the 42 School curriculum.