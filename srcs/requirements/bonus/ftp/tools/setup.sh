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
chroot_local_user=NO
anonymous_enable=NO
secure_chroot_dir=/var/run/vsftpd/empty
allow_writeable_chroot=YES
EOF

exec /usr/sbin/vsftpd /etc/vsftpd.conf
