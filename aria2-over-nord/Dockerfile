FROM armhf/alpine:3.5
RUN apk add --no-cache aria2 nginx wget openvpn unzip bash && \
    mkdir -p /data /etc/aria2 /etc/default/aria2 /run/nginx /var/www/html && \
    cd /tmp/ && \
    wget https://github.com/ziahamza/webui-aria2/archive/master.tar.gz -O /tmp/webui-aria2-master.tar.gz && \
    tar xf webui-aria2-master.tar.gz && \
    wget https://nordvpn.com/api/files/zip -O nordvpn.zip && \
    unzip nordvpn.zip -d /etc/nordvpn && \
    mv /tmp/webui-aria2-master/* /var/www/html && \
    rm -r /tmp/webui-aria2-master* /tmp/nordvpn.zip
COPY default/ /etc/default/aria2
VOLUME ["/data", "/etc/aria2"]
EXPOSE 6800 80
ENTRYPOINT /usr/bin/entrypoint.sh
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY start-ovpn.sh /usr/bin/start-ovpn.sh
