FROM debian:bookworm

RUN apt update -y && apt upgrade -y \
    && apt install -y \
    nginx \
    openssl \
    && apt clean \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 \
    -out /etc/nginx/ssl/nServer.crt \
    -keyout /etc/nginx/ssl/nServer.key \
    -subj "/CN=ozahdi.42.fr/UID=ozahdi" \
    && mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]