FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install -y nginx openssl vim && apt clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -out /etc/nginx/ssl/nginx.crt \
    -keyout /etc/nginx/ssl/nginx.key \
    -subj "/CN=ozahdi.42.fr/UID=ozahdi"


# COPY ./index.html /var/www/html/index.html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

