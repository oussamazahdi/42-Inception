FROM debian:oldstable

RUN apt update && apt install -y nginx

COPY static.html /var/www/html/static.html

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]