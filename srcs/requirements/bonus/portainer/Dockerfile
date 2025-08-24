FROM debian:bookworm

RUN apt-get update && apt-get install -y wget tar
RUN wget https://github.com/portainer/portainer/releases/download/2.27.9/portainer-2.27.9-linux-amd64.tar.gz \
    && tar -xvzf portainer-2.27.9-linux-amd64.tar.gz \
    && mv portainer /usr/local/bin/portainer \
    && rm portainer-2.27.9-linux-amd64.tar.gz

CMD ["/usr/local/bin/portainer/portainer"]
