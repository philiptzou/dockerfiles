#! /bin/sh
set -e

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
}
EOF
nginx
tor &
if ! grep "^forward-socks5t" /etc/privoxy/config; then
    echo "forward-socks5t / 127.0.0.1:9050 ." >> /etc/privoxy/config
fi
privoxy /etc/privoxy/config

if [ ! -f /etc/aria2/aria2c.conf ]; then
    cp /etc/default/aria2/aria2c.conf /etc/aria2/aria2c.conf
    touch /etc/aria2/aria2.session
fi
aria2c --conf-path /etc/aria2/aria2c.conf
