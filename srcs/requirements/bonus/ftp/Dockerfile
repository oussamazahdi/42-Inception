FROM debian:bullseye

RUN apt update && apt install -y vsftpd

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT [ "setup.sh" ]