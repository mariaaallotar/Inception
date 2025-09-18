
FROM alpine:3.21

RUN apk update && apk add mariadb mariadb-client

COPY ["tools/setup.sh", "/usr/local/bin/mariadb/setup.sh"]
RUN chmod +x /usr/local/bin/mariadb/setup.sh

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/usr/local/bin/mariadb/setup.sh"]