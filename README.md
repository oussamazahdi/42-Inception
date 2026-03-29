# Inception

Containerized infrastructure project using Docker Compose.

This repository runs a complete web stack with WordPress + MariaDB behind NGINX (TLS), plus bonus services:

- Redis cache for WordPress
- FTP service for WordPress files
- Adminer for DB management
- Static site container
- Portainer for Docker management

## Services

| Service | Purpose | Host Port |
| --- | --- | --- |
| nginx | Reverse proxy + TLS | `443` |
| wordpress | PHP-FPM WordPress app | internal (`9000`) |
| mariadb | Database | internal (`3306`) |
| redis | WordPress object cache | `6379` |
| ftp | File transfer | `21` |
| adminer | Database UI | `5000` |
| static | Static page | `127.0.0.1:3000` |
| portainer | Docker UI | `9000` |

## Prerequisites

- Docker
- Docker Compose (`docker-compose` command)
- `make`
- Linux host with permission to create:
  - `/home/ozahdi/data/wordpress`
  - `/home/ozahdi/data/mariadb`
  - `/home/ozahdi/data/portainer`

## Hostname

NGINX is configured for:

- `ozahdi.42.fr`

Add it to your hosts file if needed:

```bash
127.0.0.1 ozahdi.42.fr
```

## Environment file

Create `srcs/.env` before running:

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=change_me

DOMAIN_NAME=ozahdi.42.fr
WP_TITLE=Inception
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=change_me
WP_ADMIN_EMAIL=admin@example.com
WP_USER=user
WP_USER_EMAIL=user@example.com
WP_USER_PASSWORD=change_me

FTP_USER=ftpuser
FTP_PWD=change_me
```

## Usage

Build and start:

```bash
make
# or
make up
```

Stop:

```bash
make down
```

Full cleanup (containers/images/volumes + local data path):

```bash
make clean
```

Rebuild from scratch:

```bash
make re
```

## Notes

- Persistent data is bind-mounted under `/home/ozahdi/data`.
- NGINX uses a self-signed certificate generated at build time.
