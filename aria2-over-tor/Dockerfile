FROM armhf/alpine:3.5
ADD https://github.com/ziahamza/webui-aria2/archive/master.tar.gz /tmp/webui-aria2-master.tar.gz
RUN apk add --no-cache aria2 nginx tor privoxy && \
    mkdir -p /data /etc/aria2 /etc/default/aria2 /run/nginx /var/www/html && \
    cd /tmp/ && tar xf webui-aria2-master.tar.gz && \
    mv /tmp/webui-aria2-master/* /var/www/html && \
    rm -r /tmp/webui-aria2-master.tar.gz /tmp/webui-aria2-master
COPY default/ /etc/default/aria2
COPY entrypoint.sh /usr/bin/entrypoint.sh
VOLUME ["/data", "/etc/aria2"]
EXPOSE 6800 80
ENTRYPOINT /usr/bin/entrypoint.sh
