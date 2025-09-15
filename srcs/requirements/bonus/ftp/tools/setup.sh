#!/bin/bash
set -e

mkdir -p /var/run/vsftpd/empty


if ! id "$FTP_USER" &>/dev/null; then
    useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
fi

echo "$FTP_USER:$FTP_PWD" | chpasswd

chown -R "$FTP_USER":"$FTP_USER" /var/www/html
chmod -R 755 /var/www/html

cat > /etc/vsftpd.conf << 'EOF'
listen=YES
local_enable=YES
write_enable=YES
chroot_local_user=YES
anonymous_enable=NO
secure_chroot_dir=/var/run/vsftpd/empty
allow_writeable_chroot=YES
EOF

exec /usr/sbin/vsftpd /etc/vsftpd.conf

















# #!/bin/bash

# mkdir -p /var/run/vsftpd/empty
# mkdir -p /var/www/html/wordpress

# if ! id "$FTP_USER" &>/dev/null; then
#     # adduser --gecos "" --home /var/www/ "$FTP_USER"
#     useradd -m -d /var/www/html -s /bin/bash -g www-data "$FTP_USER"
# fi

# echo "$FTP_USER:$FTP_PWD" | chpasswd

# chown -R "$FTP_USER":www-data /var/www/html
# chmod -R 755 /var/www/html

# # Make sure the user can write to the directory
# usermod -a -G www-data "$FTP_USER"

# echo "
# listen=YES
# listen_ipv6=NO
# write_enable=YES
# local_enable=YES
# pasv_enable=YES
# chroot_local_user=YES
# anonymous_enable=NO
# ftpd_banner=Welcome to FTP Inception.
# connect_from_port_20=YES
# secure_chroot_dir=/var/run/vsftpd/empty
# allow_writeable_chroot=YES
# " > /etc/vsftpd.conf


# exec /usr/sbin/vsftpd /etc/vsftpd.conf
