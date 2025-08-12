FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install -y nginx openssl vim && apt clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 \
    -out /etc/nginx/ssl/nginx.crt \
    -keyout /etc/nginx/ssl/nginx.key \
    -subj "/CN=ozahdi.42.fr/UID=ozahdi" \
    && mkdir -p /var/run/nginx

# Remove default nginx configuration
RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy your custom configuration to the main nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Create the document root
RUN mkdir -p /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]