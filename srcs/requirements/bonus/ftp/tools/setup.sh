#!/bin/bash

mkdir -p /var/run/vsftpd/empty
mkdir -p /var/www/html/wordpress

if ! id "$FTP_USER" &>/dev/null; then
    adduser --gecos "" --home /var/www "$FTP_USER"
fi

echo "$FTP_USER:$FTP_PWD" | chpasswd

echo "
listen=YES
write_enable=YES
local_enable=YES
pasv_enable=YES
chroot_local_user=YES
anonymous_enable=NO
ftpd_banner=Welcome to FTP Inception.
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
allow_writeable_chroot=YES
" > /etc/vsftpd.conf


exec /usr/sbin/vsftpd /etc/vsftpd.conf
