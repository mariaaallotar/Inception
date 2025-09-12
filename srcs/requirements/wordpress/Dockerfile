FROM alpine:3.21.4

RUN apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-mbstring \
    php8-curl \
    php8-xml \
    php8-session \
    php8-opcache \
    php8-phar \
    php8-gd \
    wget \
    unzip \
    bash

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

RUN chown -R nobody:nobody /var/www/html

EXPOSE 9000

CMD ["php-fpm8", "-F"]