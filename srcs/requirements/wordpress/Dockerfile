FROM alpine:3.21

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-mbstring \
    php83-curl \
    php83-xml \
    php83-session \
    php83-opcache \
    php83-phar \
    php83-gd \
    wget \
    unzip

RUN mkdir -p /var/www/wp /var/www/html

COPY tools/setup.sh /usr/local/bin/wordpress/setup.sh
RUN chmod +x /usr/local/bin/wordpress/setup.sh

ARG WEB_USER
ARG WEB_GROUP
#RUN addgroup -S $WEB_GROUP
RUN adduser -D -H -s /sbin/nologin -G $WEB_GROUP $WEB_USER 

CMD ["/usr/local/bin/wordpress/setup.sh"]