FROM debian:bookworm

RUN apt update -y && apt upgrade -y

RUN apt install -y nginx openssl && apt clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -out /etc/nginx/ssl/nginx.crt \
    -keyout /etc/nginx/ssl/nginx.key \
    -subj "/CN=localhost/UID=ozahdi"

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]
