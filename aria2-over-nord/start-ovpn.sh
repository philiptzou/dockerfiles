#! /bin/bash
set -e

while true; do
    if ! kill -0 $(cat /tmp/openvpn.pid 2> /dev/null) 2> /dev/null; then
        OVPNCONFIG=`find /etc/nordvpn | grep "tw\|hk\|ca\|jp\|au" | shuf -n 1`
        openvpn --daemon --writepid /tmp/openvpn.pid --config $OVPNCONFIG --auth-user-pass /etc/nordvpn-auth.txt
        cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
        ip route add 8.8.8.8 via 172.17.42.1 dev eth0 || true
        ip route add 8.8.4.4 via 172.17.42.1 dev eth0 || true
    fi
    sleep 5
done
