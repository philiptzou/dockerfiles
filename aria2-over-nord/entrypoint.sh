#! /bin/bash
set -e

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
}
EOF
nginx
echo $OVPN_USER > /etc/nordvpn-auth.txt
echo $OVPN_PASSWORD >> /etc/nordvpn-auth.txt
ORIG_IP=`wget http://ip-api.com/csv -O - 2>/dev/null | awk -F "," '{print $NF}'`
NEW_IP=$ORIG_IP
while ! kill -0 $(cat /tmp/openvpn.pid 2> /dev/null) 2> /dev/null; do
    OVPNCONFIG=`find /etc/nordvpn | grep "tw\|hk\|ca\|jp\|au" | shuf -n 1`
    openvpn --daemon --writepid /tmp/openvpn.pid --config $OVPNCONFIG --auth-user-pass /etc/nordvpn-auth.txt
    sleep 5
done
cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
while [[ $ORIG_IP = $NEW_IP ]]; do
    NEW_IP=`wget http://ip-api.com/csv -O - 2>/dev/null | awk -F "," '{print $NF}'`
    sleep 5
done

if [ ! -f /etc/aria2/aria2c.conf ]; then
    cp /etc/default/aria2/aria2c.conf /etc/aria2/aria2c.conf
    touch /etc/aria2/aria2.session
fi
aria2c --conf-path /etc/aria2/aria2c.conf
