FROM alpine:3.21

ENV LANG=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    PUID=1000 \
    PGID=1000 \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]"

RUN apk add --no-cache \
       acme.sh \
       curl \
       fontconfig \
       net-tools \
       nginx \
       nginx-mod-stream \
       nginx-mod-http-headers-more \
       nginx-mod-http-lua \
       nginx-mod-http-brotli \
       nginx-mod-rtmp \
       openjdk8-jre \
       shadow \
       su-exec \
       logrotate \
       dumb-init \
       ttf-dejavu \
       tzdata \
       wget \
       bash \
    && fc-cache -f -v \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk/* /tmp/*

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chmod=755 src/target/nginxWebUI-*.jar /home/nginxWebUI.jar

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

VOLUME ["/home/nginxWebUI"]
